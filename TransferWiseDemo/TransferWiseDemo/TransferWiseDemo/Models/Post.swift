//
//  Station.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//


import Foundation

class Post: Codable {
    let userID, id: Int
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    init(userID: Int, id: Int, title: String, body: String) {
        self.userID = userID
        self.id = id
        self.title = title
        self.body = body
    }
}

// MARK: Convenience initializers and mutators

extension Post {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Post.self, from: data)
        self.init(userID: me.userID, id: me.id, title: me.title, body: me.body)
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
        userID: Int? = nil,
        id: Int? = nil,
        title: String? = nil,
        body: String? = nil
        ) -> Post {
        return Post(
            userID: userID ?? self.userID,
            id: id ?? self.id,
            title: title ?? self.title,
            body: body ?? self.body
        )
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}









