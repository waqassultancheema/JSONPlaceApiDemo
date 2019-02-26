//
//  PostDetailViewController.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

protocol PostDetailViewControllerGetComments
{
    func fetchComment(request:CommentRequest.Fetch.Request)
}

protocol PostDetailViewControllerDisplayedLogic {
    func displayFetchComments(viewModel:CommentsViewModel)
}

class PostDetailViewController: UIViewController,PostDetailViewControllerDisplayedLogic {
    
    

    
    @IBOutlet weak var tableView: UITableView!
    
    

    let configurator = PostDetailConfigurator()

    var requestComments: PostDetailViewControllerGetComments!
    var tableViewDataSource:PostDetailTableViewDataSource!
    var selectedPost:ViewModel.DisplayViewModel.PostListViewModel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configureTableViewDataSource()
       
        self.view.startActivityIndicator()
        
       configurator.configure(viewController: self)
       getComments()
        // Do any additional setup after loading the view.
    }
    
    func configureTableViewDataSource() {
        tableViewDataSource  = PostDetailTableViewDataSource()
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
    }
    
    func getComments() {
        var request:CommentRequest.Fetch.Request = CommentRequest.Fetch.Request()
        request.postId = "\(selectedPost.id)"
        self.requestComments.fetchComment(request: request)
    }
    
    

    func displayFetchComments(viewModel: CommentsViewModel) {
        self.tableViewDataSource.comments = viewModel.comments
        self.tableViewDataSource.post = selectedPost
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            self.view.stopActivityIndicator()
            
        }
    }
   
   
    
    
}
