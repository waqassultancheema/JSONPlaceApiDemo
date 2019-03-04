//
// PostLists.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

protocol PostListViewControllerGetPosts
{
    func fetchItems()
}

protocol PostListViewControllerDisplayedLogic {
    func displayFetchPosts(viewModel:ViewModel.DisplayViewModel)
}

class PostListViewController: UIViewController,PostListViewControllerDisplayedLogic {

    
    @IBOutlet weak var tableView: UITableView!
    
    

    let configurator = PostListConfigurator()

    var requestPosts: PostListViewControllerGetPosts!
    var router: PostListAppRouter!
    var tableViewDataSource:PostListTableViewDataSource!

    override func awakeFromNib() {
        super.awakeFromNib()
        configurator.configure(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configureTableViewDataSource()
       
        self.view.startActivityIndicator()
        self.requestPosts.fetchItems()
        handleTableViewSelection()
        // Do any additional setup after loading the view.
    }
    
    func configureTableViewDataSource() {
        tableViewDataSource  = PostListTableViewDataSource()
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
    }
    
    func displayFetchPosts(viewModel: ViewModel.DisplayViewModel) {
        self.tableViewDataSource.posts = viewModel.posts
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.stopActivityIndicator()
            
        }
    }
   
   
    
    
}
