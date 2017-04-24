//
//  ProfileViewController.swift
//  Twitter Demo
//
//  Created by Fateh Singh on 4/23/17.
//  Copyright © 2017 Fateh Singh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileTableView: UITableView!
    
    var tweets: [Tweet]! = []
    var user: User?
    var fetchDone: Bool  = false
    var userID:Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.rowHeight  = UITableViewAutomaticDimension
        profileTableView.estimatedRowHeight = 100
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        fetchDone = false
        
        var id = userID
        if id == 0 {
            id = 174514612
        }
        
        let client = TwitterClient.sharedInstance
        client.getUserTimeline(id: id, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            if self.fetchDone == true {
                self.profileTableView.reloadData()
            }
            self.fetchDone = true
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        client.getUserInfo(id: id, success: { (user: User) in
            self.user = user
            if self.fetchDone == true {
                self.profileTableView.reloadData()
            }
            self.fetchDone = true
        }) { (error: Error) in
            print(error.localizedDescription)
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderTableViewCell
            cell.user = user
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetsCell", for: indexPath) as! TweetsTableViewCell
            cell.tweet = tweets[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if (user != nil) {
                return 1
            }
        case 1:
            return tweets.count
        default:
            return 0
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? TweetDetailsViewController
        if destinationViewController != nil {
            let cell = sender as! TweetsTableViewCell
            destinationViewController?.tweetDetails = cell.tweet
            cell.setSelected(false, animated: true)
        }
    }
}
