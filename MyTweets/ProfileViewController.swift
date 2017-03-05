//
//  ProfileViewController.swift
//  MyTweets
//
//  Created by bwong on 2/26/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetNumber: UILabel!
    @IBOutlet weak var followingsNumber: UILabel!
    @IBOutlet weak var followersNumber: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var headerName: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItems()
        
        nameLabel.text = tweet.user?.name!
        screenNameLabel.text = "@\(tweet.user!.screenname!)"
        headerName.text = tweet.user?.name!
        profileImageView.setImageWith((tweet.user?.profileUrl)! as URL)
        tweetNumber.text = String(describing: tweet.user!.tweetCount)
        followingsNumber.text = String(describing: tweet.user!.followingCount)
        followersNumber.text = String(describing: tweet.user!.followersCount)        
        // Do any additional setup after loading the view.
        
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 25.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
