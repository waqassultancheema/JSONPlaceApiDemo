//
//  PostListInteractorTests.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/21/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest

@testable import TransferWiseDemo

class PostListInteractorTests: XCTestCase {
    
    var sut:PostListInteractor?
    var stubRemoteWorker:StubPostListRemoteWorker?
    var sutPostListViewController:StubPostListViewController?
    override func setUp() {
        super.setUp()
        sut = PostListInteractor()
        
        sutPostListViewController = StubPostListViewController()
        sutPostListViewController?.configureTableViewDataSource()
        
        stubRemoteWorker = StubPostListRemoteWorker()
        stubRemoteWorker?.dataToReturnOnSuccess = [PostBo.dummyPost()]

    }
    
    
    func testFetchPostListShouldPresenterCalled() {
        
        
        
        let stubPostListPresentation = StubPostListPresenter()
        stubPostListPresentation.output = sutPostListViewController
        
        sut?.output = stubPostListPresentation
        sut?.worker = stubRemoteWorker
        sut?.fetchPostList()
        
        XCTAssertTrue(stubPostListPresentation.presentFetchedOrdersCalled, "")
    }
    
    func testFetchPostListShouldAskPresenterToFormatResult() {
        
        
        
        let stubPostListPresentation = StubPostListPresenter()
        stubPostListPresentation.output = sutPostListViewController
        
        sut?.output = stubPostListPresentation
        sut?.worker = stubRemoteWorker
        sut?.fetchPostList()
        let displayPost = sutPostListViewController?.tableViewDataSource.posts.first
        XCTAssertNotNil(displayPost)
    }
    

}
