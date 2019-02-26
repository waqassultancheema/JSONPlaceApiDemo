//
//  PostDetailConfigurator.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 02/17/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit



extension AlertView where Self: PostDetailViewController {
   
    func displayalert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: "\(message) \n\nPlease Press Retry", preferredStyle: UIAlertController.Style.alert)
        alert.addAction((UIAlertAction(title: "Retry", style: .default, handler: { [unowned self] (action) -> Void in
           
            self.view.startActivityIndicator()
            self.getComments()
            alert.dismiss(animated: true, completion: nil)
            
        })))
        self.present(alert, animated: true, completion: nil)
        
        
    }
}
extension PostDetailViewController: PostDetailPresenterOutput , AlertView
{
    func successFetchedPostDetail(viewModel: CommentsViewModel) {
        self.displayFetchComments(viewModel: viewModel)
    }
    
    
    
    func errorWhileFetchingPostDetail(error: String) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.stopActivityIndicator()
            self.displayalert(title: "Error", message: error)
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // open next view controller from here
       // router.passDataToNextScene(segue: segue)
    }
}



extension PostDetailInteractor: PostDetailViewControllerGetComments
{
    func fetchComment(request: CommentRequest.Fetch.Request) {
        self.fetchComments(request: request)
    }
    
    


}

extension PostDetailPresenter: PostDetailInteractorOutput
{
    func passedToPresenterFetchedPostDetail(comments: [Comment]) {
         self.presentFetchPostDetail(comments: comments)
    }
    
    
    
    func errorWhileFetchPostDetail(error: String) {
        self.presentFetchedError(error: error)
    }
    
   
}

class PostDetailConfigurator: NSObject {

    let presenter = PostDetailPresenter()
    let interactor = PostDetailInteractor()


    // MARK: - Configuration

    func configure(viewController: PostDetailViewController)
    {


        presenter.output = viewController
        interactor.output = presenter
        viewController.requestComments = interactor
    }
}
