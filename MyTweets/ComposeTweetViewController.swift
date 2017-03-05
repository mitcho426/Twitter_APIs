//
//  ComposeTweetViewController.swift
//  MyTweets
//
//  Created by bwong on 3/4/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var tweetTextView: UITextView!
    
    var tweetMsg: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "TwitterLogoBlue"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        tweetTextView.delegate = self
        tweetTextView.layer.cornerRadius = 4.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonOnTap(_ sender: Any) {
        
        tweetMsg = tweetTextView.text
        let encodedTweetMsg = tweetMsg?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        TwitterClient.sharedInstance?.composeTweet(tweetToPost: encodedTweetMsg!)
        self.navigationController?.popViewController(animated: true)
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
