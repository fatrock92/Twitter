//
//  TweetsViewController.swift
//  Twitter Demo
//
//  Created by Fateh Singh on 4/11/17.
//  Copyright © 2017 Fateh Singh. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]! = []
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tweetsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        tweetsTableView.rowHeight  = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 100
        
        // Refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshAction), for: UIControlEvents.valueChanged)
        tweetsTableView.addSubview(refreshControl)

        let client = TwitterClient.sharedInstance
        client.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tweets.count)
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "tweetsCell", for: indexPath) as! TweetsTableViewCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    @IBAction func onSignOutButton(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? TweetDetailsViewController
        if destinationViewController != nil {
            let cell = sender as! TweetsTableViewCell
            destinationViewController?.tweetDetails = cell.tweet
            cell.setSelected(false, animated: true)
        }
    }
    
    func refreshAction() {
        let client = TwitterClient.sharedInstance
        client.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
            self.refreshControl.endRefreshing()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }

}
