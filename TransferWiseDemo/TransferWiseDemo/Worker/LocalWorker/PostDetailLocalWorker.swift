//
//  PostDetailRemoteApi.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 8/23/18.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//



class PostDetailLocalWorker {
   
    
    func fetchComments(request:CommentRequest.Fetch.Request, complete :@escaping ([CommentBo]) -> Void, failure:@escaping (String?) -> Void) {

        let commentStore = CommentStore()
        
        commentStore.fetchComments(postId: Int(request.postId) ?? 0) { (commentsBo, error) in
            if error == nil {
                complete(commentsBo)
            } else {
                failure(error?.localizedDescription)
            }
        }
    }
    
    func saveLocalComments(comments: [CommentBo], complete: @escaping (Bool?, String?) -> Void) {
        
        let commentStore = CommentStore()
        
        commentStore.saveComments(commentsToCreate: comments) { (sucess, error) in
            complete(sucess,error?.localizedDescription)
            
        }
    }
    
    
    
}
