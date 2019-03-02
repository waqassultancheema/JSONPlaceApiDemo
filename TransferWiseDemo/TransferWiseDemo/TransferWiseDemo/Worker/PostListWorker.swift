//
//  PostListWorker.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 2/28/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//


class PostListWorker {
    
    
    func fetchPostLists( complete :@escaping ([PostBo]) -> Void, failure:@escaping (String?) -> Void) {
        
        let localWorker = PostListLocalWorker()
        
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
    
    func fetchRemotePosts( complete :@escaping ([PostBo]) -> Void, failure:@escaping (String?) -> Void) {
        
        let remoteWorker = PostListRemoteWorker()
        
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
    
    func saveRemotePostsToLocal(posts: [PostBo], complete: @escaping (Bool?) -> Void, failure:@escaping (String?) -> Void) {
        
        let localWorker = PostListLocalWorker()
        
        localWorker.saveLocalPosts(posts: posts) { (success, error) in
            if success ?? false {
                complete(success)
            } else {
                failure("Can not Save")
            }
        }
        
    }
}
