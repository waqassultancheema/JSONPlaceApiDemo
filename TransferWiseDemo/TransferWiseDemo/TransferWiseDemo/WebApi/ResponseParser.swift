//
//  ResponseParser.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

protocol ParserServiceResponse {
    static func parseURLResponse(response: URLResponse?, data: Data?, completion: onCompletion,error:Error?)
}
struct Parsing {
    static let message = "Json Parsing Error"
    static let unKnown = "UnKnown Error occur, please try again"

}

class MyError: Codable {
    var status_message: String
    var status_code: Int
    
    private enum CodingKeys: String, CodingKey {
        case status_code = "code"
        case status_message = "message"
    }
}

struct ParserURLResponse:ParserServiceResponse {
    
    static func parseURLResponse(response: URLResponse?, data: Data?, completion: onCompletion,error:Error?) {
        if let httpResponse = response as? HTTPURLResponse {
            
            let code = httpResponse.statusCode
            if code == 200 {
                if data != nil {
                   completion(data, nil)
                } else {
                    completion(nil, NetworkError.unknown(Parsing.unKnown))
                }
                
            }
            else if code == 401 || code == 404 || code == 403 {
                let decoder = JSONDecoder()
                let mData = try? decoder.decode(MyError.self, from: data ?? Data())
                if let responseJSON = mData {
                    return completion(response, NetworkError.unknown(responseJSON.status_message))
                } else {
                    completion(nil, NetworkError.parsingError(Parsing.message))
                }
            } else {
                completion(nil, NetworkError.unknown(Parsing.unKnown))
            }
        } else {
            completion(nil, NetworkError.other(error?.localizedDescription ?? Parsing.unKnown))
        }
    }
}
