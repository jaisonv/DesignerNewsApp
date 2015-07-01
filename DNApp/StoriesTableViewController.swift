//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Jaison Vieira on 6/25/15.
//  Copyright (c) 2015 Jaison Vieira. All rights reserved.
//

import UIKit
import Spring
import SwiftyJSON

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate, MenuViewControllerDelegate {
    
    let transitionManager = TransitionManager()
    var stories: JSON! = []
    var isFirstTime = true
    var section = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadStories("", page: 1)
        
        refreshControl?.addTarget(self, action: "refreshStories", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if isFirstTime {
            view.showLoading()
            isFirstTime = false
        }
    }
    
    func refreshStories() {
        loadStories(section, page: 1)
    }
    
    func loadStories(section: String, page: Int) {
        DNService.storiesForSection(section, page: page) { (JSON) -> () in
            self.stories = JSON["stories"]
            self.tableView.reloadData()
            self.view.hideLoading()
            self.refreshControl?.endRefreshing()
        }
    }

    @IBAction func menuButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
    }
    
    @IBAction func loginButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("LoginSegue", sender: self)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell
        
        let story = stories[indexPath.row]
        cell.configureWithStory(story)
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("WebSegue", sender: indexPath)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: StoryTableViewCellDelegate
    
    func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: AnyObject) {
        // TODO: implement upvote
    }
    
    func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: AnyObject) {
        performSegueWithIdentifier("CommentsSegue", sender: cell)
    }
    
    // MARK: MenuViewControllerDelegate
    
    func menuViewControllerDidTouchTop(controller: MenuViewController) {
        view.showLoading()
        loadStories("", page: 1)
        navigationItem.title = "Top Stories"
        section = ""
    }
    
    func menuViewControllerDidTouchRecent(controller: MenuViewController) {
        view.showLoading()
        loadStories("recent", page: 1)
        navigationItem.title = "Recent Stories"
        section = "recent"
    }
    
    // MARK: Misc
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CommentsSegue" {
            let toView = segue.destinationViewController as? CommentsTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            toView?.story = stories[indexPath.row]
        }
        
        if segue.identifier == "WebSegue" {
            let toView = segue.destinationViewController as? WebViewController
            let indexPath = sender as! NSIndexPath
            let url = stories[indexPath.row]["url"].string!
            toView?.url = url
        
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
            
            toView?.transitioningDelegate = transitionManager
        }
        
        if segue.identifier == "MenuSegue" {
            let toView = segue.destinationViewController as? MenuViewController
            toView?.delegate = self
        }
    }
}
