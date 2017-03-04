//
//  TweetsViewController.swift
//  MyTweets
//
//  Created by bwong on 2/20/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var tweets: [Tweet]!
    var tweet: Tweet?
    var tweetId: Int = 0
    
    let client = TwitterClient.sharedInstance
    
    var refreshControl = UIRefreshControl()
    
    var isMoreDataLoading: Bool = false
    var loadingMoreView: InfiniteScrollActivityView?
    
    var imageSelected: UIImageView?
    
    @IBOutlet var tableView: UITableView!
    
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Apologies something went wrong. Please try again later..."
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(errorMessageLabel)
        
        setupNavigationBarItems()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshSetup()
        infiniteScrollingSetup()
        
        self.loadData()
        // Do any additional setup after loading the view.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        //Create a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDidTap(gesture:)))
        //Add it to the image view
        cell.tweetImage.addGestureRecognizer(tapGesture)
        cell.tweetImage.isUserInteractionEnabled = true
        
        //Created tag with indexpath.row
        cell.tweetImage.tag = indexPath.row
        
        cell.tweet = tweets[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func imageDidTap(gesture: UIGestureRecognizer) {
        //if the tapped view is a UIImageView then set it to the imageview
        if (gesture.view as? UIImageView) != nil {
            imageSelected = gesture.view as? UIImageView
            //Segue into ProfileViewController
            self.performSegue(withIdentifier: "ProfileViewController", sender: nil)
        }
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        User.currentUser = nil
        client?.logout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        self.loadData()
    }
    
    func loadData() {
        client?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            for tweet in tweets {
                print(tweet.text!)
            }
            self.refreshControl.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print("Failied to print")
            print(error.localizedDescription)
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !isMoreDataLoading {
            
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                
                isMoreDataLoading = true
                
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                self.tweetId = self.tweets[self.tweets.count - 1].id!
                
                loadMoreData()
            }
        }
    }
    
    func loadMoreData () {
        
        client?.moreHomeTimeLine(id: tweetId, success: { (tweets: [Tweet]) in
            for tweet in tweets {
                self.tweets?.append(tweet)
            }
            self.loadingMoreView!.stopAnimating()
            self.isMoreDataLoading = false
            self.tableView.reloadData()
            
        }, failure: {(error: Error) in
            print(error)
        })
    }
    
    private func refreshSetup() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        //let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    private func infiniteScrollingSetup() {
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue")
        
        if segue.identifier == "ProfileViewController" {
            
            let tweet = self.tweets[(imageSelected?.tag)!]
            let profileViewController = segue.destination as! ProfileViewController
            profileViewController.tweet = tweet
            
        } else if segue.identifier == "TweetDetailViewController" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            
            let detailVC = segue.destination as! TweetDetailViewController
            detailVC.tweet = tweet
        }
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
