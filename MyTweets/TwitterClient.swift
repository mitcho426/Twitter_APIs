//
//  TwitterClient.swift
//  MyTweets
//
//  Created by bwong on 2/20/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    //Same as BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "3jYpSbAPC1rFUudQxwSj7WY9L", consumerSecret: "2Ku8z2WeGL1cM6NXrUevvBWeCJfTJzCwwAgSEzlcU6L6kGSZLW")
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "3jYpSbAPC1rFUudQxwSj7WY9L", consumerSecret: "2Ku8z2WeGL1cM6NXrUevvBWeCJfTJzCwwAgSEzlcU6L6kGSZLW")
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        //Go to main folder -> Info Tab -> URL Types
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "MyTweets://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("I got a token!")
            //Note: Query parameters start with questionmark ?oauth_token=\(requestToken)
            let authUrl = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            UIApplication.shared.open(authUrl as URL!)
            
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            print("I got the access token")
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
            
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
            success: { (task: URLSessionDataTask?, response: Any?) in
                print("account: \(response)")
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)

                success(user)

//                print("name: \(user.name)")
//                print("screenname: \(user.screenname)")
//                print("profile url: \(user.profileUrl)")
//                print("description: \(user.tagline)")
                
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    //Created a closure in the parameters
    //If sucessful, return a array of type Tweet without response "->()"
    //If failure, return the error
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,
            success: { (task: URLSessionDataTask?, response: Any?) in
                //let tweets = response as! [NSDictionary]!
                let dictionaries = response as! [NSDictionary]
                
                let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                for tweet in tweets {
                    print("\(tweet.text!)")
                }
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func retweetFunction(id: Int, success: @escaping ([Tweet])-> (), failure: @escaping (Error) -> ()) {
        
        post("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("success retweet")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("I failed retweeting")
        }
    }
    
    func unRetweetFunction(id: Int, success: @escaping ([Tweet])-> (), failure: @escaping (Error) -> ()) {
        
        post("1.1/statuses/unretweet/\(id).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("success unretweet")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("I failed unretweet")
        }
    }
    
    func favFuction(id: Int, success: @escaping ([Tweet])-> (), failure: @escaping (Error) -> ()) {
        
        post("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("sucess favoriting")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("I failed favoriting")
        }
    }
    
    func deFavFuction(id: Int, success: @escaping ([Tweet])-> (), failure: @escaping (Error) -> ()) {
        
        post("/1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("success defavoriting")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("I failed defavoriting")
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        // NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
}


