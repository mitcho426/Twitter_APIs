//
//  User.swift
//  MyTweets
//
//  Created by bwong on 2/20/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class User: NSObject {
    
    //Stored properties
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
//    var followersCount: Int?
//    var followingCount: Int?
//    var profileBannerUrl: URL?
//    var location: String?
//    var favoriteCount: Int?
//    var tweetCount: Int?
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString) as? URL
        }
        
        tagline = dictionary["description"] as? String
    }
    
    //_ underscore hides class variable
    static var _currentUser: User?
    
    //Computed properties doesn't return storage but returns logic
    
    class var currentUser: User? {
        get {
            // _currentUser is nil, then check "currentUserData" for data
            if _currentUser == nil {
                
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                // If there is data, return data back into _currentUser
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: [])
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentuserData")
            }
            defaults.synchronize()
        }
    }
    
}
