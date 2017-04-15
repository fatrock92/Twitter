//
//  TwitterClient.swift
//  Twitter Demo
//
//  Created by Fateh Singh on 4/11/17.
//  Copyright © 2017 Fateh Singh. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "MhP3I2FndUVMKmKvJTbAQWLOk", consumerSecret: "vYtdvEkt42h3nrEbwOqVwsK5k3bNgNeqVoHkBQC6rcJYiWNlOs")!
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success:  { (requestToken: BDBOAuth1Credential!) -> Void in
            print("got token\n")
            let urlString = "https://api.twitter.com/oauth/authorize?oauth_token=" + requestToken.token
            let aURL = URL(string: urlString)!
            UIApplication.shared.open(aURL, options: [String : Any](), completionHandler: { (Bool) -> Void in
                
            })
        }) { (error: Error!) -> Void in
            print("error \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didLogOut"), object: nil)
    }
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
            self.loginSuccess?()
        }) { (error: Error!) in
            print(error?.localizedDescription ?? 0)
            self.loginFailure?(error)
        }
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let user: User = User(dictionary: response as! NSDictionary)
            success(user)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries: [NSDictionary] = response as! [NSDictionary]
            let tweets: [Tweet] = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func sendTweet(message: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        let params: Dictionary = ["status": message]
        
        post("1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func favouriteTweet(id: Int64, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        let params: Dictionary = ["id": id]
        
        post("1.1/favorites/create.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func retweetTweet(id: Int64, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        let params: Dictionary = ["id": id]
        
        post("1.1/statuses/retweet/\(id).json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    
}
