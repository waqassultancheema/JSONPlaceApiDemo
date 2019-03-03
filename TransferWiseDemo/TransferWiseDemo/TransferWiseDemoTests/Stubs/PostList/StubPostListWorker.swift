//
//  StubPostListWorker.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 3/3/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

@testable import TransferWiseDemo

class StubPostListWorker: PostListWorker {

    var dataToReturnOnSuccess:[PostBo]?
    var shouldFailOnFetch:Bool = false

    
    override func fetchPostLists(complete: @escaping ([PostBo]) -> Void, failure: @escaping (String?) -> Void) {
        let localWorker = StubPostListLocalWorker()
        localWorker.dataToReturnOnSuccess = dataToReturnOnSuccess
        localWorker.shouldFailOnFetch = shouldFailOnFetch
        localWorker.fetchLocalPosts(complete: { [unowned self ] (posts) in
            
            if posts.count == 0 {
                self.fetchRemotePosts(complete: { (posts) in
                    complete(posts)
                }, failure: { (error) in
                    failure(error)
                })
            } else {
                complete(posts)
            }
        }) { (error) in
            self.fetchRemotePosts(complete: { (posts) in
                complete(posts)
            }, failure: { (error) in
                failure(error)
            })
        }
    }
    
    override func fetchRemotePosts(complete: @escaping ([PostBo]) -> Void, failure: @escaping (String?) -> Void) {
        let remoteWorker = StubPostListRemoteWorker()
        remoteWorker.dataToReturnOnSuccess = self.dataToReturnOnSuccess
        remoteWorker.shouldFailOnFetch = self.shouldFailOnFetch
        remoteWorker.fetchPostLists(complete: { [unowned self] (posts) in
            self.saveRemotePostsToLocal(posts: posts, complete: { (sucess) in
                complete(posts)
            }, failure: { (error) in
                complete(posts)
            })
        }) { (error) in
            failure(error)
        }
    }
    
    override func saveRemotePostsToLocal(posts: [PostBo], complete: @escaping (Bool?) -> Void, failure: @escaping (String?) -> Void) {
        let localWorker = StubPostListLocalWorker()
        localWorker.shouldFailOnFetch = shouldFailOnFetch
        localWorker.saveLocalPosts(posts: posts) { (success, error) in
            if success ?? false {
                complete(success)
            } else {
                failure("Can not Save")
            }
        }
    }
    


}
