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
        
        tweetTextView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonOnTap(_ sender: Any) {
        
        tweetMsg = tweetTextView.text
        
        TwitterClient.sharedInstance?.composeTweet(tweetToPost: tweetMsg!)
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
