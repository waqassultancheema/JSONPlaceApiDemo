//
//  PostDetailWorker.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 3/2/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//


class PostDetailWorker {
    
    func fetchCommentsDetails(request:CommentRequest.Fetch.Request, complete :@escaping ([CommentBo]) -> Void, failure:@escaping (String?) -> Void) {
        
        let localWorker = PostDetailLocalWorker()
        
        localWorker.fetchComments(request: request, complete: { (comments) in
            if comments.count > 0 {
                complete(comments)
            } else {
                self.fetchRemoteComments(request: request, complete: { (comments) in
                    complete(comments)
                }, failure: { (error) in
                    failure(error)
                })
            }
        }) { (error) in
            self.fetchRemoteComments(request: request, complete: { (comments) in
                complete(comments)
            }, failure: { (error) in
                failure(error)
            })
        }
        
        
        
    }
    
    func fetchRemoteComments(request:CommentRequest.Fetch.Request, complete :@escaping ([CommentBo]) -> Void, failure:@escaping (String?) -> Void) {
        
        let remoteWorker = PostDetailRemoteWorker()
        
        remoteWorker.fetchCommentsDetails(request: request, complete: { (comments) in
            self.saveRemoteCommentsToLocal(comments: comments, complete: { (sucess) in
                complete(comments)
            }, failure: { (error) in
                complete(comments)
            })
        }) { (error) in
            failure(error)
        }
    }
    
    func saveRemoteCommentsToLocal(comments: [CommentBo], complete: @escaping (Bool?) -> Void, failure:@escaping (String?) -> Void) {
        
        let localWorker = PostDetailLocalWorker()
        
        localWorker.saveLocalComments(comments: comments) { (sucess, error) in
            if (sucess ?? false) == true {
                complete(sucess)
            } else {
                failure(error)
            }
        }
        
        
        
    }
}
