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
    let client = TwitterClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
//        let startPosition: UITextPosition = tweetTextView.beginningOfDocument
//        let endPosition: UITextPosition = tweetTextView.endOfDocument
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonOnTap(_ sender: Any) {
        
        tweetMsg = tweetTextView.text
        
        client?.composeTweet(tweetToPost: tweetMsg!)
        dismiss(animated: true, completion: nil)
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
