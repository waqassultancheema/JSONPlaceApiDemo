//
//  StubPostDetailWorker.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 3/3/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

@testable import TransferWiseDemo

class StubPostDetailWorker: PostDetailWorker {

    var shouldFailOnFetch:Bool = false
    var dataToReturnOnSuccess:[CommentBo]?
    
    
    override func fetchCommentsDetails(request: CommentRequest.Fetch.Request, complete: @escaping ([CommentBo]) -> Void, failure: @escaping (String?) -> Void) {
        let localWorker = StubPostDetailLocalWorker()
        localWorker.dataToReturnOnSuccess = dataToReturnOnSuccess
        localWorker.shouldFailOnFetch = shouldFailOnFetch
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
    
    override func fetchRemoteComments(request: CommentRequest.Fetch.Request, complete: @escaping ([CommentBo]) -> Void, failure: @escaping (String?) -> Void) {
        let remoteWorker = StubPostDetailRemoteWorker()
        remoteWorker.shouldFailOnFetch = shouldFailOnFetch
        remoteWorker.dataToReturnOnSuccess = dataToReturnOnSuccess

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
    
    override func saveRemoteCommentsToLocal(comments: [CommentBo], complete: @escaping (Bool?) -> Void, failure: @escaping (String?) -> Void) {
        let localWorker = StubPostDetailLocalWorker()
        localWorker.shouldFailOnFetch = shouldFailOnFetch
        localWorker.dataToReturnOnSuccess = dataToReturnOnSuccess
        localWorker.saveLocalComments(comments: comments) { (sucess, error) in
            if (sucess ?? false) == true {
                complete(sucess)
            } else {
                failure(error)
            }
        }
    }
}
