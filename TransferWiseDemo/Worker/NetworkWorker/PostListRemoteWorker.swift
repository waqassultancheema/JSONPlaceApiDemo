//
//  PostListRemoteApi.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 8/23/18.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//



import UIKit
let PostList = 1
typealias Posts = [PostBo]
class PostListRemoteWorker: NSObject,WebAPIHandler {
   
     private var requestURLString = "\(APIURLPrefix)/posts"
    
    func fetchPostLists( complete :@escaping ([PostBo]) -> Void, failure:@escaping (String?) -> Void) {
        
        getDataFromServer(url: requestURLString) { (response, error) in
            guard error == nil else {
                failure(error?.localizedDescription)
                return
            }
            
            if let mData = response as? Data {
                do {
                   let posts = try Posts(data: mData)
                   complete(posts)
                } catch  {
                    failure(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
    
    
    
}
