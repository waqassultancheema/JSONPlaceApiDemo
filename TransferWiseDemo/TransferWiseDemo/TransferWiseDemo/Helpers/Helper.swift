//
//  Helper.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 2/18/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation
import UIKit
extension Data {
    func elements <T> () -> [T] {
        return withUnsafeBytes {
            Array(UnsafeBufferPointer<T>(start: $0, count: count/MemoryLayout<T>.size))
        }
    }
}


extension Array where Element == Posts.Element {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Posts.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


extension UIView {
    
   
    func startActivityIndicator() {
        ActivityIndicator.sharedInstance.showProgressView(view: self)
    }
    
    func stopActivityIndicator() {
        ActivityIndicator.sharedInstance.hideProgressView()
    }
    
  
}
