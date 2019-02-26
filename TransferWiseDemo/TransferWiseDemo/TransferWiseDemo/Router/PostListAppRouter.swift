//
//  PostListAppRouter.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

protocol PostListAppRouterView {
    func showDetailViewController(post:ViewModel.DisplayViewModel.PostListViewModel)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class PostListAppRouter: PostListAppRouterView {
    
    
    
    
    var postListViewController:PostListViewController? = nil
    var navigationController:UINavigationController? = nil
    
    var selectedPost:ViewModel.DisplayViewModel.PostListViewModel?
    
    func showDetailViewController(post: ViewModel.DisplayViewModel.PostListViewModel) {
        selectedPost = post
        postListViewController?.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postDetailViewController = segue.destination as? PostDetailViewController {
            postDetailViewController.selectedPost = selectedPost
            
        }
    }
    

  
  
    
    
}

