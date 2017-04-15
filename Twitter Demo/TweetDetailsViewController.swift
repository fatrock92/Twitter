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
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
