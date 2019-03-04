//
//  PostListTableViewDataSource.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

class PostListTableViewDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var posts:[ViewModel.DisplayViewModel.PostListViewModel] = Array<ViewModel.DisplayViewModel.PostListViewModel>()
    
    public var postSelected: ((ViewModel.DisplayViewModel.PostListViewModel) -> ())?

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PostListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostListTableViewCell", for: indexPath) as! PostListTableViewCell
        
        let post:ViewModel.DisplayViewModel.PostListViewModel = posts[indexPath.row]

        cell.labelTitle.text = post.title
        cell.labelBody.text = post.body

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post:ViewModel.DisplayViewModel.PostListViewModel = posts[indexPath.row]

        self.postSelected!(post)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    
}
