//
//  PostTests.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/18/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest
@testable import TransferWiseDemo

class PostTests: XCTestCase {

    var jsonPostsDictionaryStub : [Dictionary<String,AnyObject>]!

    override func setUp() {
        super.setUp()
        jsonPostsDictionaryStub = loadJSONDictionaryFromBundle(withName: "posts", extension: "json")
    }

//    override func tearDown() {
//
//    }
    
    func testShouldReturnLoadedJSON() {
        XCTAssertNotNil(jsonPostsDictionaryStub)
    }
    
    func testShouldHaveAtLeastOnePost() {
        
        XCTAssertGreaterThan(jsonPostsDictionaryStub.count, 0)
    }
    
    func testShouldCreatePostFromDictionary()  {
        let firstPostJson = jsonPostsDictionaryStub.first
        do {
             let post = try Post(firstPostJson!)
             XCTAssertNotNil(post)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
       
        
    }
    func testShouldGetId() {
        let firstPostJson = jsonPostsDictionaryStub.first
        do {
            let post = try Post(firstPostJson!)
            XCTAssertNotNil(post.id)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
        
    }
    
    func testShouldGetUserId() {
        let firstPostJson = jsonPostsDictionaryStub.first
        do {
            let post = try Post(firstPostJson!)
            XCTAssertNotNil(post.userID)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
        
    }
    
    func testShouldGetTitle() {
        let firstPostJson = jsonPostsDictionaryStub.first
        do {
            let post = try Post(firstPostJson!)
            XCTAssertNotNil(post.title)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
        
    }
    
    func testShouldGetBody() {
        let firstPostJson = jsonPostsDictionaryStub.first
        do {
            let post = try Post(firstPostJson!)
            XCTAssertNotNil(post.body)
        } catch {
            XCTFail("Problem in Parsing of Dictioanry")
        }
        
    }
    
    
    func testUserIdShouldBePositiveNumber() {
        let post =  Post(userID: 0, id: 0, title: "", body: "")
        XCTAssertGreaterThanOrEqual(post.userID, 0)
    }
    
    func testUserIdShouldBeGreaterThanZero() {
        let post =  Post(userID: 1, id: 1, title: "", body: "")
        XCTAssertGreaterThanOrEqual(post.userID, 1)
    }
    
    func testIdShouldBeGreaterThanZero() {
        let post =  Post(userID: 1, id: 1, title: "", body: "")
        XCTAssertGreaterThanOrEqual(post.id, 1)
    }
    
    func testIdShouldBePositiveNumber() {
        let post =  Post(userID: 0, id: 0, title: "", body: "")
        XCTAssertGreaterThanOrEqual(post.id, 0)
    }
    
    
    
    
    

    

}
