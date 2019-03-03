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
    
    
    
    var commentStore: CoreDataStore = CoreDataStore()

    func fetchComments(postId:Int, completionHandler: @escaping ([CommentBo], StoreError?) -> Void) {
        commentStore.privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Comment")
                fetchRequest.predicate = NSPredicate(format: "postId == %d", postId)

                let results = try self.commentStore.privateManagedObjectContext.fetch(fetchRequest) as! [Comment]
                
                let comments = results.map { $0.toCommentBo() }
                completionHandler(comments, nil)
            }catch {
                completionHandler([], StoreError.CannotFetch("Cannot fetch Comments"))
            }
        }
    }
    
    func saveComments(commentsToCreate: [CommentBo], completionHandler: @escaping (Bool?, StoreError?) -> Void) {
        commentStore.privateManagedObjectContext.perform {
            do {
                for commentBo in commentsToCreate {
                    let comment = NSEntityDescription.insertNewObject(forEntityName: "Comment", into: self.commentStore.privateManagedObjectContext) as! Comment
                    comment.fromCommentBo(commentBo: commentBo)
                    try self.commentStore.privateManagedObjectContext.save()
                }
                completionHandler(true, nil)
            } catch {
                completionHandler(nil, StoreError.CannotCreate("Comments Saving Problem"))
            }
        }
    }
    

}
