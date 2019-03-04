//
//  ActivityIndicator.swift
//  TransferWiseDemo
//
//  Created by Waqas Sultan on 2/18/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

class ActivityIndicator {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var sharedInstance: ActivityIndicator {
        struct Static {
            static let instance: ActivityIndicator = ActivityIndicator()
        }
        return Static.instance
    }
    
    func showProgressView(view: UIView) {
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        //        containerView.center = view.center
        containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = containerView.center
        progressView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
