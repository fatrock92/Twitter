//
//  HamburgerViewController.swift
//  Twitter Demo
//
//  Created by Fateh Singh on 4/23/17.
//  Copyright © 2017 Fateh Singh. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentViewLeftMarginConstraint: NSLayoutConstraint!
    
    var originalLeftMargin: CGFloat!
    var menuVC: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuVC.view)
        }
    }
    var contentVC: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            contentView.addSubview(contentVC.view)
            
            UIView.animate(withDuration: 0.3) {
                self.contentViewLeftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalLeftMargin = contentViewLeftMarginConstraint.constant
        } else if sender.state == UIGestureRecognizerState.changed {
            contentViewLeftMarginConstraint.constant = originalLeftMargin + translation.x
        } else if sender.state == UIGestureRecognizerState.ended {
            
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
                    self.contentViewLeftMarginConstraint.constant = self.view.frame.size.width - 50
                } else {
                    self.contentViewLeftMarginConstraint.constant = 0
                }
            })
        }
        
    }


}
