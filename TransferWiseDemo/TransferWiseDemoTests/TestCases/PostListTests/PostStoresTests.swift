//
//  PostStoresTests.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 3/3/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest
@testable import TransferWiseDemo
class PostStoresTests: XCTestCase {

    
    var sut:PostStore!
    var testPosts:[PostBo]!
    override func setUp() {
        super.setUp()
        sut = PostStore()
        testPosts = [PostBo.dummyPost()]

    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
   
    
    func testFetchPostsShoudlListofPosts() {
        
        var fetchedPosts = [PostBo]()
        let expect = expectation(description: "Wait for fetchPost() to return")
        
        sut.fetchPosts { (posts, error) in
            fetchedPosts = posts
            expect.fulfill()

        }
        waitForExpectations(timeout: 1.0)
        XCTAssertGreaterThan(fetchedPosts.count, 0)
    }
    
    
    func testFetchPostsErrorShouldBeNil() {
        
        var fetchPostsError: StoreError?
        let expect = expectation(description: "Wait for fetchPost() to return")
        
        sut.fetchPosts { (posts, error) in
            fetchPostsError = error
            expect.fulfill()
            
        }
        waitForExpectations(timeout: 1.0)
        XCTAssertNil(fetchPostsError, "fetchPost() should not return an error")
    }
    
    
    func testCreatePostShouldNotSendError() {
        var fetchPostsError: StoreError?
        var success: Bool?
        let expect = expectation(description: "Wait for createPost() to return")
        sut.savePosts(postsToCreate: testPosts) { (scuess, error) in
            success = scuess
            fetchPostsError = error
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    
        XCTAssertNil(fetchPostsError, "savePosts() should not return an error")
        XCTAssertTrue(success ?? false)
    }
  

}
