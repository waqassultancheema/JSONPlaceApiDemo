//
//  TimetableRequest.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit


    struct ViewModel {
        
        
        struct DisplayViewModel {
            struct PostListViewModel {
                var title:String = ""
                var body:String = ""
                var id:Int = 0

            }
            var posts:[DisplayViewModel.PostListViewModel]
        }
        
        
    }

