//
//  WebAPI.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit
import Foundation

typealias onCompletion = (Any?, NetworkError?)->()




protocol WebAPIHandler {
    func getDataFromServer(url: String,completion: @escaping onCompletion)
}

extension WebAPIHandler {
    
    func getDataFromServer(url: String,completion: @escaping onCompletion) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, NetworkError.noNetwork)
            return
        }
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        if let urL = URL(string: urlString) {
            let request = URLRequest(url: urL)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) -> Void in
                ParserURLResponse.parseURLResponse(response: response, data: data, completion: completion,error: error)
            }
            task.resume()
        }
    }
    
    
}







