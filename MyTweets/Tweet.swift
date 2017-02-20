//
//  Tweet.swift
//  MyTweets
//
//  Created by bwong on 2/20/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        
        //If int == nil, then int = 0
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            timeStamp = formatter.date(from: timestampString)
        }
    }
    
    //Class function is a function of this class
    //Class function that returns an array of class type Tweet
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        //Create a empty array of type Tweet
        var tweets = [Tweet]()
        
        //Iterate through the dictionaries
        for dictionary in dictionaries {
            //Create a tweet based on that dictionary
            let tweet = Tweet(dictionary: dictionary)
            //Add all the tweets to that dictionary array
            tweets.append(tweet)
        }
        //Then return the tweets
        return tweets
    }
}
