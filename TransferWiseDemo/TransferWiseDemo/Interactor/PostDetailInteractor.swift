//
//  PostDetailInteractor.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

protocol PostDetailInteractorInput {

    func fetchComments(request:CommentRequest.Fetch.Request)
}

protocol PostDetailInteractorOutput {
    func passedToPresenterFetchedPostDetail(comments:[CommentBo])
    func errorWhileFetchPostDetail(error:String)


}
class PostDetailInteractor:PostDetailInteractorInput {
   
    var output: PostDetailInteractorOutput!
    var worker: PostDetailWorker!
    
    func fetchComments(request:CommentRequest.Fetch.Request) {
        if worker == nil {
            worker = PostDetailWorker()
        }
        worker.fetchCommentsDetails(request: request,complete: { [unowned self] (comments) in
            self.output.passedToPresenterFetchedPostDetail(comments: comments)
        }) { (error) in
            self.output.errorWhileFetchPostDetail(error: error ?? "Error Occured While Fetching")

        }
        
       }

}
