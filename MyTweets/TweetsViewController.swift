//
//  TweetsViewController.swift
//  MyTweets
//
//  Created by bwong on 2/20/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]!
    var tweet: Tweet?
    let client = TwitterClient.sharedInstance
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
//      tableView.estimatedRowHeight = 140
//      tableView.rowHeight = UITableViewAutomaticDimension
        
        self.loadData()
        // Do any additional setup after loading the view.
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.tweets != nil {
            return self.tweets.count
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        User.currentUser = nil
        client?.logout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        client?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            for tweet in tweets {
                print(tweet.text!)
            }
            print("Tweet count: \(tweets.count)")
            
        }, failure: { (error: Error) in
            print("Failied to print")
            print(error.localizedDescription)
        })
    self.tableView.reloadData()
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
