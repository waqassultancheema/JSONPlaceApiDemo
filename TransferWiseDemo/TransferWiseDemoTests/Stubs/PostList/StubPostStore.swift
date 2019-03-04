//
//  StubPostStore.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 3/3/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

@testable import TransferWiseDemo

class StubPostStore: PostStore {
    
    var dataToReturnOnSuccess:[PostBo]?
    var shouldFailOnFetch:Bool = false

    override func fetchPosts(completionHandler: @escaping ([PostBo], StoreError?) -> Void) {
        
        if shouldFailOnFetch == false {
            completionHandler(dataToReturnOnSuccess!,nil)
        } else {
            completionHandler([],StoreError.CannotFetch("Fetching Problem"))

        }
    }
    
    override func savePosts(postsToCreate: [PostBo], completionHandler: @escaping (Bool?, StoreError?) -> Void) {
        if shouldFailOnFetch == false {
            completionHandler(true,nil)
        } else {
            completionHandler(false,StoreError.CannotFetch("Fetching Problem"))
            
        }
    }

}
