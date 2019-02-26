//
//  StubPostDetailViewController.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/21/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit
@testable import TransferWiseDemo
class StubPostDetailViewController: PostDetailViewController {

    
    override func configureTableViewDataSource() {
        tableViewDataSource  = PostDetailTableViewDataSource()
    }
    
    override func displayFetchComments(viewModel: CommentsViewModel) {
        tableViewDataSource.comments = viewModel.comments
    }


}
