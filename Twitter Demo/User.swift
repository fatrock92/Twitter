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
    var tagline: String?
    var userDictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        userDictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)
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
