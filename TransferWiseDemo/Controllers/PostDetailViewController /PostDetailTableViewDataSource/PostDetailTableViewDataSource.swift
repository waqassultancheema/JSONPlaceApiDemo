//
//  PostDetailTableViewDataSource.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

class PostDetailTableViewDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var comments:[CommentsViewModel.DisplayViewModel] = Array<CommentsViewModel.DisplayViewModel>()
    
    var post:ViewModel.DisplayViewModel.PostListViewModel = ViewModel.DisplayViewModel.PostListViewModel()

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Post"
        } else {
            return "Comments"
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell:PostDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostDetailTableViewCell", for: indexPath) as! PostDetailTableViewCell
            
            cell.labelTitle.text = post.title
            cell.labelBody.text = post.body
              return cell
        } else {
            let cell:CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
            let comment:CommentsViewModel.DisplayViewModel = comments[indexPath.row]
            cell.labelBody.text = comment.body
            cell.labelTitle.text = comment.name
            cell.labelEmail.text = comment.email
              return cell

        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return  comments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    
}
