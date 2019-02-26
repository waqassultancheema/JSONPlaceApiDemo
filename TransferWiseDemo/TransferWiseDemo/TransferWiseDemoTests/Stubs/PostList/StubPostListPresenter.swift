//
//  StubPostListPresenter.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/24/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation
@testable import TransferWiseDemo
class StubPostListPresenter: PostListPresenter {

    var presentFetchedOrdersCalled = false
    
    
    override func presentFetchPostList(posts: [Post]) {
        super.presentFetchPostList(posts: posts)
        presentFetchedOrdersCalled = true
    }
    

}
