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
    
    var favFlag: Bool?
    var retweetFlag: Bool?
    
    var tweet : Tweet! {
        didSet {
            nameLabel.text = tweet.user?.name!
            screenameLabel.text = "@\(tweet.user!.screenname!)"
            tweetImage.setImageWith((tweet.user?.profileUrl)! as URL)
            descriptionLabel.text = tweet.user?.tagline
            timestampLabel.text = tweet.timeStampString!
            
            retweetCount.text = String(describing: tweet.retweetCount)
            favCount.text = String(describing: tweet.favoritesCount)
            
            replyImageButton.setImage(UIImage(named: "reply-icon.png"), for: UIControlState.normal)
            retweetImageButton.setImage(UIImage(named: "retweet-icon.png"), for: UIControlState.normal)
            favImageButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
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

    @IBAction func replyOnTap(_ sender: Any) {
        
    }
    
    @IBAction func favOnTap(_ sender: Any) {
        //flag for pressed/not pressed
        
    }
    
    @IBAction func retweetOnTap(_ sender: Any) {
        //flag for pressed/not pressed
    }
}
