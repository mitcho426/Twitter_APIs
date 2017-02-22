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
    @IBOutlet weak var tweetLabel: UILabel!
    

    var tweet : Tweet! {
        didSet {
            nameLabel.text = "dadwa"
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

}
