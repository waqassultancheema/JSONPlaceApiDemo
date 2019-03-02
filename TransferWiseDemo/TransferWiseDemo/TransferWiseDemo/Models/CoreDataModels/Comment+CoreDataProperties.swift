//
//  Comment+CoreDataProperties.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 2/28/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var postId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var body: String?
    
    
    func toCommentBo() -> CommentBo{
        return CommentBo(postID: Int(self.postId), id: Int(self.id) , name: self.name ?? "", email: self.email ?? "", body: self.body ?? "")
        
    }
    func fromCommentBo(commentBo:CommentBo){
        self.name = commentBo.name
        self.email = commentBo.email
        self.body = commentBo.body


        self.id  = Int16(commentBo.id)
        self.postId  = Int16(commentBo.postID)

    }

}
