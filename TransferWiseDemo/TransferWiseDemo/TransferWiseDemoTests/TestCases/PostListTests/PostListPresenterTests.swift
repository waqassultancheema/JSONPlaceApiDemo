//
//  PostListPresenterTests.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/20/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest

@testable import TransferWiseDemo

class PostListPresenterTests: XCTestCase {

    var stubPost:PostBo?
    var sutPres:PostListPresenter?

    override func setUp() {
        super.setUp()
        stubPost = PostBo.dummyPost()
        sutPres = PostListPresenter()
    }
    
    
    func testPresentPostListShouldFormatPostForDisplay() {
        
        let sutPostListViewController:StubPostListViewController = StubPostListViewController()
        sutPostListViewController.configureTableViewDataSource()
        sutPres?.output = sutPostListViewController
        sutPres?.presentFetchPostList(posts: [stubPost!])
        let displayPost = sutPostListViewController.tableViewDataSource.posts.first
        XCTAssertNotNil(displayPost)
    }

    


}
