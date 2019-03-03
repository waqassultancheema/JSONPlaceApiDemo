//
//  StubPostDetailLocalWorker.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 3/3/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

@testable import TransferWiseDemo

class StubPostDetailLocalWorker: PostDetailLocalWorker {

    var shouldFailOnFetch:Bool = false
    var dataToReturnOnSuccess:[CommentBo]?
    override func fetchComments(request: CommentRequest.Fetch.Request, complete: @escaping ([CommentBo]) -> Void, failure: @escaping (String?) -> Void) {
        let commentStore = StubCommentStore()
        
        commentStore.dataToReturnOnSuccess = dataToReturnOnSuccess
        commentStore.shouldFailOnFetch = self.shouldFailOnFetch
        commentStore.fetchComments(postId: Int(request.postId) ?? 0) { (commentsBo, error) in
            if error == nil {
                complete(commentsBo)
            } else {
                failure(error?.localizedDescription)
            }
        }
    }
    
    override func saveLocalComments(comments: [CommentBo], complete: @escaping (Bool?, String?) -> Void) {
        let commentStore = StubCommentStore()
        commentStore.shouldFailOnFetch = self.shouldFailOnFetch

        commentStore.saveComments(commentsToCreate: comments) { (sucess, error) in
            complete(sucess,error?.localizedDescription)
            
        }
    }
    
}
