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
    
    @IBOutlet weak var loginButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "twitter-down.png")
        self.view.insertSubview(backgroundImage, at: 0)
        
        loginButtonLabel.layer.cornerRadius = 4.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLoginButton(_ sender: Any) {

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
