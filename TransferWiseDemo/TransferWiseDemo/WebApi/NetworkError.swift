//
//  NetworkError.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation


enum NetworkError: Error {
    case noNetwork
    case serverError(String)
    case parsingError(String)
    case unknown(String)
    case other(String)
}

extension NetworkError: LocalizedError {
    
    var localizedDescription : String {
        
        switch self {
        case .noNetwork:
            return "Please check your internet connection."
        case .serverError(let error):
            return error
        case .parsingError(let error):
            return error
        case .unknown(let error):
            return error
        case .other(let error):
            return error
        }
    }
}
