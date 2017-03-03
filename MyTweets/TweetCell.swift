//
//  TweetCell.swift
//  MyTweets
//
//  Created by bwong on 2/20/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var replyImageButton: UIButton!
    @IBOutlet weak var retweetImageButton: UIButton!
    @IBOutlet weak var favImageButton: UIButton!
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    
    let client = TwitterClient.sharedInstance
    
    var tweet : Tweet! {
        
        didSet {
            nameLabel.text = tweet.user?.name!
            screenameLabel.text = "@\(tweet.user!.screenname!)"
            tweetImage.setImageWith((tweet.user?.profileUrl)! as URL)
            descriptionLabel.text = tweet.user?.tagline
            timestampLabel.text = tweet.timeStamp!
            
            retweetCount.text = String(describing: tweet.retweetCount)
            favCount.text = String(describing: tweet.favoritesCount)
            
            if !tweet.favFlag{
                favImageButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
            } else {
                favImageButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            }
            
            if !tweet.retweetFlag {
                retweetImageButton.setImage(UIImage(named: "retweet-icon.png"), for: UIControlState.normal)
            } else {
                retweetImageButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
            }
            
            replyImageButton.setImage(UIImage(named: "reply-icon.png"), for: UIControlState.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //Not yet implemented
    @IBAction func replyOnTap(_ sender: Any) {
        
    }
    
    @IBAction func favOnTap(_ sender: Any) {
        
        if !tweet.favFlag {
            favImageButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            //Post fav
            client?.favFuction(id: tweet.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (Error) in
                print("failed")
            })
            
            favCount.text = String(tweet.favoritesCount + 1)
            tweet.favFlag = true
        } else {
            favImageButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
            //Withdraw fav
            client?.deFavFuction(id: tweet.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (Error) in
                print("failed")
            })
            
            favCount.text = String(tweet.favoritesCount)
            tweet.favFlag = false
        }
    }
    
    @IBAction func retweetOnTap(_ sender: Any) {
        
        if !tweet.retweetFlag {
            retweetImageButton.setImage(UIImage(named:"retweet-icon-green.png"), for: UIControlState.normal)
            
            client?.retweetFunction(id: tweet.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: Error) in
                print("failed")
            })
            
            retweetCount.text = String(tweet.retweetCount + 1)
            tweet.retweetFlag = true
            
        } else {
            retweetImageButton.setImage(UIImage(named:"retweet-icon.png"), for: UIControlState.normal)
            
            client?.unRetweetFunction(id: tweet.id!, success: { (tweets:[Tweet]) in
                print("success")
            }, failure: { (error: Error) in
                print("failed")
            })
            
            retweetCount.text = String(tweet.retweetCount)
            tweet.retweetFlag = false
        }
    }
}
