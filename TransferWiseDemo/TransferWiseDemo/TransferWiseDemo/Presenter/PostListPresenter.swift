//
//  PostListPresenter.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//


import UIKit
protocol PostListPresenterInput
{
    func presentFetchPostList(posts:[Post])
    func presentFetchedError(error:String)
}

protocol PostListPresenterOutput: class
{
    func successFetchedPostList(viewModel: ViewModel.DisplayViewModel)
    func errorWhileFetchingPostList(error:String)
}
class PostListPresenter:PostListPresenterInput {
 
    var output:PostListPresenterOutput!
    
    func presentFetchPostList(posts: [Post]) {
        if let output  = output {
            
            if posts.count == 0 {
               output.errorWhileFetchingPostList(error: "No Posts Found")
            }

            let postsDisplayModel =  convertDataIntoViewModel(posts: posts)
            
            let viewModel = ViewModel.DisplayViewModel.init(posts: postsDisplayModel)
            
            output.successFetchedPostList(viewModel:viewModel)
        }
       

    }
    
    func presentFetchedError(error: String) {
         output.errorWhileFetchingPostList(error: error)
    }
    
    
    func convertDataIntoViewModel(posts:[Post]) ->  [ViewModel.DisplayViewModel.PostListViewModel] {

        var displayViewModels:[ViewModel.DisplayViewModel.PostListViewModel] = []

        for post in posts {

                var postListViewModel:ViewModel.DisplayViewModel.PostListViewModel = ViewModel.DisplayViewModel.PostListViewModel()
                postListViewModel.title = post.title.capitalized
                postListViewModel.body = post.body.capitalized
                postListViewModel.id = post.id
                displayViewModels.append(postListViewModel)
            }
        return displayViewModels
    }
}


