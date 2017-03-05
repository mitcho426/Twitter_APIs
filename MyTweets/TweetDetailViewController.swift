//
//  TweetDetailViewController.swift
//  MyTweets
//
//  Created by bwong on 2/26/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet: Tweet!
    
    let client = TwitterClient.sharedInstance
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var numOfRetweetAndFAV: UILabel!

    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItems()
    
        profileImageView.setImageWith((tweet.user?.profileUrl)! as URL)
        nameLabel.text = tweet.user?.name!
        screenNameLabel.text = "@\(tweet.user!.screenname!)"
        descriptionLabel.text = tweet.user?.tagline
        timestampLabel.text = "\(tweet.timeStamp!) ago"
        
        replyButton.isHighlighted = false
        
        //Using one label to render data for retweet and favourites

        numOfRetweetAndFAV.text = "\(tweet.retweetCount) RETWEET \(tweet.favoritesCount) FAVOURITES"
        
        if !tweet.favFlag{
            favButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
        }
        
        if !tweet.retweetFlag {
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: UIControlState.normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
        }
        
        replyButton.setImage(UIImage(named: "reply-icon.png"), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func replyOnTap(_ sender: Any) {
        
    }
    @IBAction func retweetOnTap(_ sender: Any) {
        if !tweet.retweetFlag {
            retweetButton.setImage(UIImage(named:"retweet-icon-green.png"), for: UIControlState.normal)
            
            client?.retweetFunction(id: tweet.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: Error) in
                print("failed")
            })
            tweet.retweetFlag = true
            
        } else {
            retweetButton.setImage(UIImage(named:"retweet-icon.png"), for: UIControlState.normal)
            
            client?.unRetweetFunction(id: tweet.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: Error) in
                print("failed")
            })
            tweet.retweetFlag = false
        }
    }
    
    @IBAction func favOnTap(_ sender: Any) {
        if !tweet.favFlag {
            favButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            //Post fav
            client?.favFuction(id: tweet.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (Error) in
                print("failed")
            })
            tweet.favFlag = true
        } else {
            favButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
            //Withdraw fav
            client?.deFavFuction(id: tweet.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (Error) in
                print("failed")
            })
            tweet.favFlag = false
        }
    }
    
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
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
