//
//  Comment.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 2/25/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

typealias Comments = [Comment]

class Comment: Codable {
    let postID, id: Int
    let name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
    
    init(postID: Int, id: Int, name: String, email: String, body: String) {
        self.postID = postID
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
}

// MARK: Convenience initializers and mutators

extension Comment {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Comment.self, from: data)
        self.init(postID: me.postID, id: me.id, name: me.name, email: me.email, body: me.body)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    convenience init(_ jsonDic: Dictionary<String,AnyObject>) throws {
        let jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
        try self.init(data: jsonData)
        
    }
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        postID: Int? = nil,
        id: Int? = nil,
        name: String? = nil,
        email: String? = nil,
        body: String? = nil
        ) -> Comment {
        return Comment(
            postID: postID ?? self.postID,
            id: id ?? self.id,
            name: name ?? self.name,
            email: email ?? self.email,
            body: body ?? self.body
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Array where Element == Comments.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Comments.self, from: data)
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
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


