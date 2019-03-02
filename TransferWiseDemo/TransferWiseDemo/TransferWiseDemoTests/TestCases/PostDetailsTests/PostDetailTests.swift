//
//  PostDetailTests.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/18/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest
@testable import TransferWiseDemo

class PostDetailTests: XCTestCase {

    var jsonCommentsDictionaryStub : [Dictionary<String,AnyObject>]!

    override func setUp() {
        super.setUp()
        jsonCommentsDictionaryStub = loadJSONDictionaryFromBundle(withName: "comments", extension: "json")
    }

//    override func tearDown() {
//
//    }
    
    func testShouldReturnLoadedJSON() {
        XCTAssertNotNil(jsonCommentsDictionaryStub)
    }
    
    func testShouldHaveAtLeastOnePost() {
        
        XCTAssertGreaterThan(jsonCommentsDictionaryStub.count, 0)
    }
    
    func testShouldCreatePostFromDictionary()  {
        let firstPostJson = jsonCommentsDictionaryStub.first
        do {
             let comment = try CommentBo(firstPostJson!)
             XCTAssertNotNil(comment)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
       
        
    }
    func testShouldGetId() {
        let firstPostJson = jsonCommentsDictionaryStub.first
        do {
            let comment = try CommentBo(firstPostJson!)
            XCTAssertNotNil(comment.id)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
        
    }
    
    func testShouldGetName() {
        let firstPostJson = jsonCommentsDictionaryStub.first
        do {
            let comment = try CommentBo(firstPostJson!)
            XCTAssertNotNil(comment.name)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
        
    }
    
    func testShouldGetEmail() {
        let firstPostJson = jsonCommentsDictionaryStub.first
        do {
            let comment = try CommentBo(firstPostJson!)
            XCTAssertNotNil(comment.email)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
        
    }
    
    func testShouldGetBody() {
        let firstPostJson = jsonCommentsDictionaryStub.first
        do {
            let comment = try CommentBo(firstPostJson!)
            XCTAssertNotNil(comment.body)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
        
    }
    
    
    func testPostIdShouldBePositiveNumber() {
        let comment =  CommentBo(postID: 0, id: 0, name: "", email: "", body: "")
        XCTAssertGreaterThanOrEqual(comment.postID, 0)
    }
    
    func testIdShouldBeGreaterThanZero() {
        let comment =  CommentBo(postID: 0, id: 1, name: "", email: "", body: "")
        XCTAssertGreaterThanOrEqual(comment.id, 1)
    }
    
    

}
