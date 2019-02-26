//
//  StubPostListService.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/20/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

@testable import TransferWiseDemo
class StubPostListRemoteWorker: PostListRemoteWorker {

    var shouldFailOnFetch:Bool = false
    var dataToReturnOnSuccess:[Post]?
    

    
    override func fetchPostLists(complete: @escaping ([Post]) -> Void, failure: @escaping (String?) -> Void) {
        if shouldFailOnFetch {
            failure(NetworkError.other("Test failing").localizedDescription)
        } else {
            if let data = dataToReturnOnSuccess {
                complete(data)
            }
        }
    }
    
}
