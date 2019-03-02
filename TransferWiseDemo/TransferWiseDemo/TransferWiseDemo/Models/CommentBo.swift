//
//  Comment.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 2/25/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

typealias Comments = [CommentBo]

struct CommentBo: Codable {
    let postID, id: Int
    let name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

// MARK: Convenience initializers and mutators

extension CommentBo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CommentBo.self, from: data)
    }
    
    static func dummyComment() -> CommentBo  {
        return CommentBo(postID: 1, id: 1, name: "Dummy Title", email: "a@abc.com", body: "")
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
    
    init(_ jsonDic: Dictionary<String,AnyObject>) throws {
        let jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
        try self.init(data: jsonData)
        
    }
    
    func with(
        postID: Int? = nil,
        id: Int? = nil,
        name: String? = nil,
        email: String? = nil,
        body: String? = nil
        ) -> CommentBo {
        return CommentBo(
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

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func commentsTask(with url: URL, completionHandler: @escaping (Comments?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
/*
import CoreData
typealias Comments = [Comment]

class Comment: NSManagedObject,Codable {
    @NSManaged   var postID, id: Int
    @NSManaged   var name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
    
    
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Comment", in: managedObjectContext) else {
                fatalError("Failed to decode Comment")
        }
        
        self.init(entity:entity,insertInto:nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.postID = try container.decodeIfPresent(Int.self, forKey: .postID)!
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)!
        self.name = try container.decodeIfPresent(String.self, forKey: .name)!
        self.email = try container.decodeIfPresent(String.self, forKey: .email)!
        self.body = try container.decodeIfPresent(String.self, forKey: .body)!
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
   
    
}

// MARK: Convenience initializers and mutators

extension Comment {
    
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Comment.self, from: data)
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = newJSONDecoder().userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Comment", in: managedObjectContext) else {
                fatalError("Failed to decode Comment")
        }
        self.init(entity:entity,insertInto:nil)

        self.postID = me.postID
        self.id = me.id
        self.name = me.name
        self.email = me.email
        self.body = me.body
        try managedObjectContext.save()
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

*/
