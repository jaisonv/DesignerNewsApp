//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Jaison Vieira on 6/25/15.
//  Copyright (c) 2015 Jaison Vieira. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {


    @IBAction func menuButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
    }
    
    @IBAction func loginButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("LoginSegue", sender: self)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! UITableViewCell
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("WebSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
