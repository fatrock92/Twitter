//
//  TweetDetailsViewController.swift
//  Twitter Demo
//
//  Created by Fateh Singh on 4/14/17.
//  Copyright © 2017 Fateh Singh. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favouritesLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var favouriteImage: UIImageView!
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    
    var tweetDetails: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tweetDetails != nil {
            nameLabel.text = tweetDetails?.user?.name
            usernameLabel.text = tweetDetails.user?.screenName
            descriptionLabel.text = tweetDetails.text
            retweetLabel.text = "\(tweetDetails.retweetCount) RETWEETS"
            favouritesLabel.text = "\(tweetDetails.favouritesCount) FAVOURITES"
            profileImage.setImageWith((tweetDetails.user?.profileURL)!)
            
            let favouriteTap = UITapGestureRecognizer(target: self, action: #selector(TweetDetailsViewController.favouriteTapDetected))
            favouriteTap.numberOfTapsRequired = 1 // you can change this value
            favouriteImage.isUserInteractionEnabled = true
            favouriteImage.addGestureRecognizer(favouriteTap)
            
            let replyTap = UITapGestureRecognizer(target: self, action: #selector(TweetDetailsViewController.replyTapDetected))
            replyTap.numberOfTapsRequired = 1 // you can change this value
            replyImage.isUserInteractionEnabled = true
            replyImage.addGestureRecognizer(replyTap)
            
            let retweetTap = UITapGestureRecognizer(target: self, action: #selector(TweetDetailsViewController.retweetTapDetected))
            retweetTap.numberOfTapsRequired = 1 // you can change this value
            retweetImage.isUserInteractionEnabled = true
            retweetImage.addGestureRecognizer(retweetTap)
            
            let profileTap = UITapGestureRecognizer(target: self, action: #selector(TweetDetailsViewController.profileImageTapDetected))
            profileTap.numberOfTapsRequired = 1 // you can change this value
            profileImage.isUserInteractionEnabled = true
            profileImage.addGestureRecognizer(profileTap)
            
        }
        // Do any additional setup after loading the view.
    }
    
    //Action
    func favouriteTapDetected() {
        print("Imageview Clicked")
        let id = tweetDetails.id
        let client = TwitterClient.sharedInstance
        client.favouriteTweet(id: id, success: {
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    //Action
    func replyTapDetected() {
        print("Imageview Clicked")
    }
    
    //Action
    func retweetTapDetected() {
        print("Imageview Clicked")
        let id = tweetDetails.id
        let client = TwitterClient.sharedInstance
        client.retweetTweet(id: id, success: {
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    func profileImageTapDetected() {
        print("Imageview Clicked")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.userID = (tweetDetails.user?.userID) ?? 0
        self.navigationController?.pushViewController(profileVC, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
