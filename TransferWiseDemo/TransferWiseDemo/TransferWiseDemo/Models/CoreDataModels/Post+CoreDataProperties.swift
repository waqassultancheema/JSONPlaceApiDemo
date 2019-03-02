//
//  Post+CoreDataProperties.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 2/28/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: Int16
    @NSManaged public var body: String?
    
    
    func toPostBo() -> PostBo{
        return PostBo(userID: 0, id: Int(self.id), title: self.title ?? "", body: self.body ?? "")
        
    }
    func fromPostBo(postBo:PostBo){
       self.title = postBo.title
        self.id  = Int16(postBo.id)
        self.body = postBo.body
    }

}
