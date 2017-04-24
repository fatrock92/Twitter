//
//  User.swift
//  Twitter Demo
//
//  Created by Fateh Singh on 4/11/17.
//  Copyright © 2017 Fateh Singh. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var profileBannerURL: URL?
    var tagline: String?
    var userDictionary: NSDictionary?
    var tweets: Int = 0
    var following: Int = 0
    var followers: Int = 0
    var userID: Int64 = 0
    
    init(dictionary: NSDictionary) {
        userDictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        followers = (dictionary["followers_count"] as? Int) ?? 0
        tweets = (dictionary["statuses_count"] as? Int) ?? 0
        following = (dictionary["friends_count"] as? Int) ?? 0
        userID = (dictionary["id"] as? Int64) ?? 0
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)
        }
        
        let profileBannerURLString = dictionary["profile_banner_url"] as? String
        if let profileBannerURLString = profileBannerURLString {
            profileBannerURL = URL(string: profileBannerURLString)
        }
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if (_currentUser == nil) {
                let userData = UserDefaults.standard.object(forKey: "currentUser") as? Data
                if let userData = userData {
                    let dict = try! JSONSerialization.jsonObject(with: userData, options: [])
                    _currentUser = User(dictionary: dict as! NSDictionary)
                }
            }
            print(_currentUser ?? "")
            return _currentUser
        }
        set(user) {
            
            if let user = user {
                let dict = user.userDictionary!
                let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
                UserDefaults.standard.set(data, forKey: "currentUser")
            } else {
                UserDefaults.standard.set(nil, forKey: "currentUser")
            }
            UserDefaults.standard.synchronize()
            
        }
    }
}
