//
//  PostListRemoteApi.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 8/23/18.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//



class PostListLocalWorker {
   

    
    func fetchLocalPosts( complete :@escaping ([PostBo]) -> Void, failure:@escaping (String?) -> Void) {
        
        let  postStore = PostStore()
    
        postStore.fetchPosts { (posts, error) in
            complete(posts)
        }
      //  failure("No Posts Found")
    }
    
    func saveLocalPosts(posts: [PostBo], complete: @escaping (Bool?, String?) -> Void) {
        
          let  postStore = PostStore()
    
        postStore.savePosts(postsToCreate: posts) { (success, error) in
            complete(success,error?.localizedDescription)
        }
    }
    
    
    
    
    
    
    
}
