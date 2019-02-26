//
//  PostDetailInteractorTests.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/21/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest

@testable import TransferWiseDemo

class PostDetailInteractorTests: XCTestCase {
    
    var sut:PostDetailInteractor?
    var stubRemoteWorker:StubPostDetailRemoteWorker?
    var sutPostDetailViewController:StubPostDetailViewController?
     var request:CommentRequest.Fetch.Request = CommentRequest.Fetch.Request()
    override func setUp() {
        super.setUp()
        sut = PostDetailInteractor()
        
        sutPostDetailViewController = StubPostDetailViewController()
        sutPostDetailViewController?.configureTableViewDataSource()
        
        stubRemoteWorker = StubPostDetailRemoteWorker()
        stubRemoteWorker?.dataToReturnOnSuccess = [StubComments.dummyComment()]
        
       
        

    }
    
    
    func testFetchCommentsShouldPresenterCalled() {
        
        
        
        let stubPostDetailPresentation = StubPostDetailPresenter()
        stubPostDetailPresentation.output = sutPostDetailViewController
        
        sut?.output = stubPostDetailPresentation
        sut?.worker = stubRemoteWorker
        request.postId = "\(1)"
        sut?.fetchComment(request: request)
        
        XCTAssertTrue(stubPostDetailPresentation.presentFetchedOrdersCalled, "")
    }
    
    func testFetchCommentsShouldAskPresenterToFormatResult() {
        
        
        
        let stubPostDetailPresentation = StubPostDetailPresenter()
        stubPostDetailPresentation.output = sutPostDetailViewController
        
        sut?.output = stubPostDetailPresentation
        sut?.worker = stubRemoteWorker
        request.postId = "\(1)"
        sut?.fetchComment(request: request)
        let displayComments = sutPostDetailViewController?.tableViewDataSource.comments.first
        XCTAssertNotNil(displayComments)
    }
    

}
