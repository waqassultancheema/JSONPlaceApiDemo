//
//  PostListInteractor.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

protocol PostListInteractorInput {

    func fetchPostList()
}

protocol PostListInteractorOutput {
    func passedToPresenterFetchedPostList(posts:[PostBo])
    func errorWhileFetchPostList(error:String)


}
class PostListInteractor:PostListInteractorInput {

    var output: PostListInteractorOutput!
    var worker: PostListWorker!
    
    func fetchPostList() {
        if worker == nil {
            worker = PostListWorker()
        }
        worker.fetchPostLists( complete: { [unowned self] (posts) in
            self.output.passedToPresenterFetchedPostList(posts: posts)
        }) { (error) in
            self.output.errorWhileFetchPostList(error: error ?? "Error Occured While Fetching")

        }
        
       }

}
