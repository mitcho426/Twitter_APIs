//
//  tweetViewController+navbar.swift
//  MyTweets
//
//  Created by bwong on 3/2/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

extension TweetsViewController {
    
    func setupNavigationBarItems() {
        setupNavigationTitleView()
        setupNavigationRightBarItems()
    }
    
    private func setupNavigationTitleView() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "TwitterLogoBlue"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupNavigationRightBarItems() {
        let composeButton = UIButton(type: .system)
        composeButton.setImage(#imageLiteral(resourceName: "edit-icon").withRenderingMode(.alwaysOriginal), for: .normal)
        composeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: composeButton)
        
        composeButton.addTarget(self, action: #selector(composeTapped(gesture:)), for: .touchUpInside)
    }
    
    @objc private func composeTapped(gesture: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Compose") as! ComposeViewController
//        
//        self.present(nextViewController, animated: true, completion: nil)
        
        self.performSegue(withIdentifier: "ComposeTweetViewController", sender: nil)
    }
    
    
}
