//
//  NewTweetViewController.swift
//  Twitter Demo
//
//  Created by Fateh Singh on 4/14/17.
//  Copyright © 2017 Fateh Singh. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet weak var tweetText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweetButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        let message = tweetText.text ?? ""
        let client = TwitterClient.sharedInstance
        client.sendTweet(message: message, success: {
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
    }

    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
