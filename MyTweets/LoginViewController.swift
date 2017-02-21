//
//  LoginViewController.swift
//  MyTweets
//
//  Created by bwong on 2/19/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        //Twitter API for Auth
//        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "3jYpSbAPC1rFUudQxwSj7WY9L", consumerSecret: "2Ku8z2WeGL1cM6NXrUevvBWeCJfTJzCwwAgSEzlcU6L6kGSZLW")

        let client = TwitterClient.sharedInstance
        
        client?.login(success: {            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        

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
