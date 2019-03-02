//
//  StubPostDetailPresenter.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/24/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation
@testable import TransferWiseDemo
class StubPostDetailPresenter: PostDetailPresenter {

    var presentFetchedOrdersCalled = false
    
    
    override func presentFetchPostDetail(comments: [CommentBo]) {
        super.presentFetchPostDetail(comments: comments)
        presentFetchedOrdersCalled = true
    }
    

}
