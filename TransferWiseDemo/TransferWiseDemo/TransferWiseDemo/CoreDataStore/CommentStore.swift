//
//  CommentStore.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 2/28/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import CoreData
//import Foundation
protocol CommentStoreProtocal {
    func fetchComments(postId:Int, completionHandler: @escaping ([CommentBo], StoreError?) -> Void)
    func saveComments(commentsToCreate: [CommentBo], completionHandler: @escaping (Bool?, StoreError?) -> Void)

}

class CommentStore:CommentStoreProtocal {
    
    
    
    var ordersStore: CoreDataStore = CoreDataStore()

    func fetchComments(postId:Int, completionHandler: @escaping ([CommentBo], StoreError?) -> Void) {
        ordersStore.privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Comment")
                fetchRequest.predicate = NSPredicate(format: "postId == %d", postId)

                let results = try self.ordersStore.privateManagedObjectContext.fetch(fetchRequest) as! [Comment]
                
                let comments = results.map { $0.toCommentBo() }
                completionHandler(comments, nil)
            }catch {
                completionHandler([], StoreError.CannotFetch("Cannot fetch Comments"))
            }
        }
    }
    
    func saveComments(commentsToCreate: [CommentBo], completionHandler: @escaping (Bool?, StoreError?) -> Void) {
        ordersStore.privateManagedObjectContext.perform {
            do {
                for commentBo in commentsToCreate {
                    let comment = NSEntityDescription.insertNewObject(forEntityName: "Comment", into: self.ordersStore.privateManagedObjectContext) as! Comment
                    comment.fromCommentBo(commentBo: commentBo)
                    try self.ordersStore.privateManagedObjectContext.save()
                }
                completionHandler(true, nil)
            } catch {
                completionHandler(nil, StoreError.CannotCreate("Comments Saving Problem"))
            }
        }
    }
    

}
