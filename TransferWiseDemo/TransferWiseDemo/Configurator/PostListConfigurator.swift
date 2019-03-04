//
//  PostListConfigurator.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

protocol AlertView   {
     func displayalert(title:String, message:String)
}

extension AlertView where Self: PostListViewController {
   
    func displayalert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: "\(message) \n\nPlease Press Retry", preferredStyle: UIAlertController.Style.alert)
        alert.addAction((UIAlertAction(title: "Retry", style: .default, handler: { [unowned self] (action) -> Void in
           
            self.view.startActivityIndicator()
            self.requestPosts.fetchItems()
            alert.dismiss(animated: true, completion: nil)
            
        })))
        self.present(alert, animated: true, completion: nil)
        
        
    }
}





extension PostListViewController: PostListPresenterOutput , AlertView
{
    func successFetchedPostList(viewModel: ViewModel.DisplayViewModel) {
        self.displayFetchPosts(viewModel: viewModel)
    }
    
    func errorWhileFetchingPostList(error: String) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.stopActivityIndicator()
            self.displayalert(title: "Error", message: error)
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        router.prepare(for: segue, sender: sender)
    }
    
    func handleTableViewSelection() {
        self.tableViewDataSource.postSelected  = { [unowned self] (post) in
            self.router.showDetailViewController(post: post)

        }
        
    }
}



extension PostListInteractor: PostListViewControllerGetPosts
{
    func fetchItems() {
          self.fetchPostList()
    }


}

extension PostListPresenter: PostListInteractorOutput
{
    func passedToPresenterFetchedPostList(posts: [PostBo]) {
        self.presentFetchPostList(posts: posts)

    }
    
    
    func errorWhileFetchPostList(error: String) {
        self.presentFetchedError(error: error)
    }
    
   
}

class PostListConfigurator: NSObject {

    let presenter = PostListPresenter()
    let interactor = PostListInteractor()
    let router = PostListAppRouter()


    // MARK: - Configuration

    func configure(viewController: PostListViewController)
    {
        router.postListViewController = viewController


        presenter.output = viewController
        

        interactor.output = presenter

        viewController.requestPosts = interactor
        viewController.router = router
    }
}
