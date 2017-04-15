//
//  TweetsTableViewCell.swift
//  Twitter Demo
//
//  Created by Fateh Singh on 4/12/17.
//  Copyright © 2017 Fateh Singh. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            descriptionLabel.text = tweet.text
            nameLabel.text        = tweet.user?.name
            usernameLabel.text    = "@\(tweet.user?.screenName ?? "")"
            
            let currentDate: Date = Date()
            var t: TimeInterval = currentDate.timeIntervalSince(tweet.timeStamp!)
            t = t/3600
            timeLabel.text        = "\(Int(t))h"
            
            if tweet.user?.profileURL != nil {
                profileImage.setImageWith(tweet.user!.profileURL!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
