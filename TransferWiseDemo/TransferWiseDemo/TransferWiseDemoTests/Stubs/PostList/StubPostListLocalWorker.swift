//
//  StubPostListLocalWorker.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 3/3/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

@testable import TransferWiseDemo

class StubPostListLocalWorker: PostListLocalWorker {
    
    var dataToReturnOnSuccess:[PostBo]?
    var shouldFailOnFetch:Bool = false
    
    override func fetchLocalPosts(complete: @escaping ([PostBo]) -> Void, failure: @escaping (String?) -> Void) {
        
        let    postStore = StubPostStore()
        
        postStore.dataToReturnOnSuccess = dataToReturnOnSuccess
        postStore.shouldFailOnFetch = self.shouldFailOnFetch
        postStore.fetchPosts { (posts, error) in
            complete(posts)
        }
    }
    
    override func saveLocalPosts(posts: [PostBo], complete: @escaping (Bool?, String?) -> Void) {
        let  postStore = StubPostStore()
        
        postStore.savePosts(postsToCreate: posts) { (success, error) in
            complete(success,error?.localizedDescription)
        }
    }

}
