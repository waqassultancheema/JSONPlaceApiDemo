//
//  PostDetailPresenter.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//


import UIKit
protocol PostDetailPresenterInput
{
    func presentFetchPostDetail(comments:[Comment])
    func presentFetchedError(error:String)
}

protocol PostDetailPresenterOutput: class
{
    func successFetchedPostDetail(viewModel: CommentsViewModel)
    func errorWhileFetchingPostDetail(error:String)
}
class PostDetailPresenter:PostDetailPresenterInput {
 
    var output:PostDetailPresenterOutput!
    
    func presentFetchPostDetail(comments: [Comment]) {
        if let output  = output {
            
            if comments.count == 0 {
               output.errorWhileFetchingPostDetail(error: "No Posts Found")
            }

            let postsDisplayModel =  convertDataIntoViewModel(comments: comments)
            
            let viewModel = CommentsViewModel.init(comments: postsDisplayModel)
            
            output.successFetchedPostDetail(viewModel:viewModel)
        }
       

    }
    
    func presentFetchedError(error: String) {
         output.errorWhileFetchingPostDetail(error: error)
    }
    
    
    func convertDataIntoViewModel(comments:[Comment]) ->  [CommentsViewModel.DisplayViewModel] {

        var displayViewModels:[CommentsViewModel.DisplayViewModel] = []

        for commnt in comments {

                var comment:CommentsViewModel.DisplayViewModel = CommentsViewModel.DisplayViewModel()
                comment.name = commnt.name.capitalized
                comment.body = commnt.body.capitalized
                comment.email = commnt.email
                displayViewModels.append(comment)
            }
        return displayViewModels
    }
}


