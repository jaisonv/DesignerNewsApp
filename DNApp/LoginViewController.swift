//
//  LoginViewController.swift
//  DNApp
//
//  Created by Jaison Vieira on 6/22/15.
//  Copyright (c) 2015 Jaison Vieira. All rights reserved.
//

import UIKit
import Spring

class LoginViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonTouch(sender: AnyObject) {
        dialogView.animation = "shake"
        dialogView.animate()
    }

    @IBAction func closeButtonDidTouch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
