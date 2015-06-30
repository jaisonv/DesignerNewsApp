//
//  LearnViewController.swift
//  DNApp
//
//  Created by Jaison Vieira on 6/25/15.
//  Copyright (c) 2015 Jaison Vieira. All rights reserved.
//

import UIKit
import Spring

class LearnViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var bookImageView: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        dialogView.animate()
    }
    
    @IBAction func learnButtonDidTouch(sender: AnyObject) {
        bookImageView.animation = "pop"
        bookImageView.animate()
        
        openURL("http://designcode.io")
    }
    
    @IBAction func closeButtonDidTouch(sender: AnyObject) {
        dialogView.animation = "fall"
        dialogView.animateNext() {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func twitterButtonDidTouch(sender: AnyObject) {
        openURL("http://twiter.com/MengTo")
    }
    
    
    func openURL(url: String) {
        let targetURL = NSURL(string: url)
        UIApplication.sharedApplication().openURL(targetURL!)
    }
}
