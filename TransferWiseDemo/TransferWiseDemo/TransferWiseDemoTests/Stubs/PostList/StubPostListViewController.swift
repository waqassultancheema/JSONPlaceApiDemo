//
//  StubPostListViewController.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/21/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit
@testable import TransferWiseDemo
class StubPostListViewController: PostListViewController {

    
    override func configureTableViewDataSource() {
        tableViewDataSource  = PostListTableViewDataSource()
    }
    
    override func displayFetchPosts(viewModel: ViewModel.DisplayViewModel) {
          tableViewDataSource.posts = viewModel.posts
    }
//     func successFetchedPostList(viewModel: ViewModel.DisplayViewModel) {
//        self.tableViewDataSource.posts = viewModel.posts
//    }

}
