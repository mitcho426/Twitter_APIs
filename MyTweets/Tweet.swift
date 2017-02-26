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
    var timeStamp: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var id: Int?
    
    var retweetFlag: Bool = false
    var favFlag: Bool = false
    
    var user: User?
    
    init(dictionary: NSDictionary) {
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        
        id = (dictionary["id"] as? Int) ?? 0
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            let timeStampInSeconds = formatter.date(from: timestampString)!
            timeStamp = Tweet.formatTweetTimeStamp(timeStampInSeconds.timeIntervalSinceNow)
        }
        
        retweetFlag = dictionary["favorited"] as! Bool
        favFlag = dictionary["retweeted"] as! Bool
    }
    
    //Ryan assisted func
    //Converts seconds into a short string of time
    class func formatTweetTimeStamp(_ tweetTimeStamp: TimeInterval) -> String{
        var time = Int(tweetTimeStamp)
        var timeSinceTweet: Int = 0
        var timeLabelCharacter = ""
        
        time = time * -1
        
        if (time < 60) {//Seconds ago
            timeSinceTweet = time
            timeLabelCharacter = "s"
        } else if ((time/60) <= 60) { //Minutes ago
            timeSinceTweet = time / 60
            timeLabelCharacter = "m"
        } else if ((time/60/60) <= 24){ //Hours ago
            timeSinceTweet = time/60/60
            timeLabelCharacter = "h"
        } else if((time/60/60/24) <= 365){ //Days ago
            timeSinceTweet = time/60/60/24
            timeLabelCharacter = "d"
        } else if((time/60/60/24/365) <= 1){ //Years ago
            timeSinceTweet = time/60/60/24/365
            timeLabelCharacter = "y"
        }
        
        return("\(timeSinceTweet)\(timeLabelCharacter)")
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
