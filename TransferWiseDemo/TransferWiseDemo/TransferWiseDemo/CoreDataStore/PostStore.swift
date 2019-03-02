//
//  PostStore.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 2/28/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import CoreData

protocol PostStoreProtocal {
    func fetchPosts(completionHandler: @escaping ([PostBo], StoreError?) -> Void)
    func savePosts(postsToCreate: [PostBo], completionHandler: @escaping (Bool?, StoreError?) -> Void)

}

class PostStore:PostStoreProtocal {
    
    
    
    var ordersStore: CoreDataStore = CoreDataStore()

    func fetchPosts(completionHandler: @escaping ([PostBo], StoreError?) -> Void) {
        ordersStore.privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
                let results = try self.ordersStore.privateManagedObjectContext.fetch(fetchRequest) as! [Post]
                let posts = results.map { $0.toPostBo() }
                completionHandler(posts, nil)
            }catch {
                completionHandler([], StoreError.CannotFetch("Cannot fetch Posts"))
            }
        }
    }
    
    func savePosts(postsToCreate: [PostBo], completionHandler: @escaping (Bool?, StoreError?) -> Void) {
        ordersStore.privateManagedObjectContext.perform {
            do {
                for postBo in postsToCreate {
                    let post = NSEntityDescription.insertNewObject(forEntityName: "Post", into: self.ordersStore.privateManagedObjectContext) as! Post
                    post.fromPostBo(postBo: postBo)
                    try self.ordersStore.privateManagedObjectContext.save()
                }
                completionHandler(true, nil)
            } catch {
                completionHandler(nil, StoreError.CannotCreate("Posts Saving Problem"))
            }
        }
    }
    

}
