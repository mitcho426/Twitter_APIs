//
//  TweetsViewController.swift
//  MyTweets
//
//  Created by bwong on 2/20/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets: [Tweet]?
    let client = TwitterClient.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        client?.currentAccount()
        
        client?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text!)
            }
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })


        // Do any additional setup after loading the view.
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        User.currentUser = nil
        client?.logout()
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
