//
//  StubCommentStore.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 3/3/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

@testable import TransferWiseDemo

class StubCommentStore: CommentStore {

    var shouldFailOnFetch:Bool = false
    var dataToReturnOnSuccess:[CommentBo]?
    override func fetchComments(postId: Int, completionHandler: @escaping ([CommentBo], StoreError?) -> Void) {
        if shouldFailOnFetch {
            completionHandler([],StoreError.CannotFetch("Can Not Fetch Comments"))
        } else {
            completionHandler(dataToReturnOnSuccess!,nil)
        }
    }
    
    override func saveComments(commentsToCreate: [CommentBo], completionHandler: @escaping (Bool?, StoreError?) -> Void) {
        if shouldFailOnFetch {
            completionHandler(false,StoreError.CannotCreate("Comments Saving Problem"))
        } else {
            completionHandler(true,nil)
        }
    }
}
