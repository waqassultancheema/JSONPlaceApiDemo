//
//  PostDetailPresenterTests.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/20/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest

@testable import TransferWiseDemo

class PostDetailPresenterTests: XCTestCase {

    var stubComment:StubComments?
    var sutPres:PostDetailPresenter?

    override func setUp() {
        super.setUp()
        stubComment = StubComments.dummyComment()
        sutPres = PostDetailPresenter()
    }
    
    
    func testPresentPostListShouldFormatPostForDisplay() {
        
        let stubPostDetailViewController:StubPostDetailViewController = StubPostDetailViewController()
        stubPostDetailViewController.configureTableViewDataSource()
        sutPres?.output = stubPostDetailViewController
        sutPres?.presentFetchPostDetail(comments: [stubComment!])
        let displayComment = stubPostDetailViewController.tableViewDataSource.comments.first
        XCTAssertNotNil(displayComment)
    }

    


}
