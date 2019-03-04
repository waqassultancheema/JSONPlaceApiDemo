//
//  TimetableRequest.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

enum CommentRequest {
    enum Fetch
    {
        struct Request
        {
            
            var postId = ""
            var mURL: String {
                
                let url = String(format: APIURLPrefix + "/comments?postId=\(postId)")
                return url
            }
        }
    }
}


    struct CommentsViewModel {
        
       
        struct DisplayViewModel {
            
                var name:String = ""
                var email:String = ""
                var body:String = ""
            
        }
         var comments:[DisplayViewModel]
        
    }

