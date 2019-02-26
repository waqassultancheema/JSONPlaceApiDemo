//
//  StubPostDetailService.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/20/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

@testable import TransferWiseDemo
class StubPostDetailRemoteWorker: PostDetailRemoteWorker {

    var shouldFailOnFetch:Bool = false
    var dataToReturnOnSuccess:[Comment]?
    

    override func fetchCommentsDetails(request: CommentRequest.Fetch.Request, complete: @escaping ([Comment]) -> Void, failure: @escaping (String?) -> Void) {
        if shouldFailOnFetch {
            failure(NetworkError.other("Test failing").localizedDescription)
        } else {
            if let data = dataToReturnOnSuccess {
                complete(data)
            }
        }
    }
    
   
    
}
