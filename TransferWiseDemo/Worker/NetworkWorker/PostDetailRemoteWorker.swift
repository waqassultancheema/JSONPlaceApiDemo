//
//  PostDetailRemoteApi.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 8/23/18.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//



import UIKit
let PostDetail = 1
class PostDetailRemoteWorker: NSObject,WebAPIHandler {
   
    
    func fetchCommentsDetails(request:CommentRequest.Fetch.Request, complete :@escaping ([CommentBo]) -> Void, failure:@escaping (String?) -> Void) {

        getDataFromServer(url: request.mURL) { (response, error) in
            guard error == nil else {
                failure(error?.localizedDescription)
                return
            }
            
            if let mData = response as? Data {
                do {
                   let posts = try Comments(data: mData)
                   complete(posts)
                } catch  {
                    failure(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
    
    
    
}
