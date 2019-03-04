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
    
    
    
    var postsStore: CoreDataStore = CoreDataStore()

    func fetchPosts(completionHandler: @escaping ([PostBo], StoreError?) -> Void) {
        postsStore.privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
                let results = try self.postsStore.privateManagedObjectContext.fetch(fetchRequest) as! [Post]
                let posts = results.map { $0.toPostBo() }
                completionHandler(posts, nil)
            }catch {
                completionHandler([], StoreError.CannotFetch("Cannot fetch Posts"))
            }
        }
    }
    
    func savePosts(postsToCreate: [PostBo], completionHandler: @escaping (Bool?, StoreError?) -> Void) {
        postsStore.privateManagedObjectContext.perform {
            do {
                for postBo in postsToCreate {
                    let post = NSEntityDescription.insertNewObject(forEntityName: "Post", into: self.postsStore.privateManagedObjectContext) as! Post
                    post.fromPostBo(postBo: postBo)
                    try self.postsStore.privateManagedObjectContext.save()
                }
                completionHandler(true, nil)
            } catch {
                completionHandler(nil, StoreError.CannotCreate("Posts Saving Problem"))
            }
        }
    }
    
    func deletePost(postId: Int, completionHandler: @escaping (Bool?, StoreError?) -> Void) {
        postsStore.privateManagedObjectContext.perform {
            do {
               
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
                fetchRequest.predicate = NSPredicate(format: "id == %d", postId)
                let results = try self.postsStore.privateManagedObjectContext.fetch(fetchRequest) as! [Post]
                if let post = results.first {
                    self.postsStore.privateManagedObjectContext.delete(post)
                }
                do {
                    try self.postsStore.privateManagedObjectContext.save()
                    completionHandler(true, nil)
                } catch {
                    completionHandler(false, StoreError.CannotDelete("Unable to Delete the post with \(postId) Id"))
                }
                completionHandler(true, nil)
            } catch {
                completionHandler(nil, StoreError.CannotCreate("Posts Delete Problem"))
            }
        }
    }
    

}
