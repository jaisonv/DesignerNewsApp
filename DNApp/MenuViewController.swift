//
//  MenuViewController.swift
//  DNApp
//
//  Created by Jaison Vieira on 6/25/15.
//  Copyright (c) 2015 Jaison Vieira. All rights reserved.
//

import UIKit
import Spring

class MenuViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableImageView!
    
    @IBAction func closeButtonDidTouch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        dialogView.animation = "fall"
        dialogView.animate()
    }

}
