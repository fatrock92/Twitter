//
//  HeaderTableViewCell.swift
//  Twitter Demo
//
//  Created by Fateh Singh on 4/23/17.
//  Copyright © 2017 Fateh Singh. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileBannerImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var user: User! {
        didSet {
            nameLabel.text        = user.name
            usernameLabel.text    = "@\(user.screenName ?? "")"
            tweetsLabel.text      = "\(user.tweets )"
            followingLabel.text   = "\(user.following)"
            followersLabel.text   = "\(user.followers)"
            
            if user.profileURL != nil {
                profileImage.setImageWith(user.profileURL!)
            }
            
            if user.profileBannerURL != nil {
                profileBannerImage.setImageWith(user.profileBannerURL!)
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
