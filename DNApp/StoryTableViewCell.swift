//
//  StoryTableViewCell.swift
//  DNApp
//
//  Created by Jaison Vieira on 6/25/15.
//  Copyright (c) 2015 Jaison Vieira. All rights reserved.
//

import UIKit
import Spring


protocol StoryTableViewCellDelegate: class {
    func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: AnyObject)
    func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: AnyObject)
}

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var upvoteButton: SpringButton!
    @IBOutlet weak var commentButton: SpringButton!
    @IBOutlet weak var commentTextView: AutoTextView!
    weak var delegate: StoryTableViewCellDelegate?
    
    @IBAction func upvoteButtonDidTouch(sender: AnyObject) {
        upvoteButton.animation = "pop"
        upvoteButton.force = 3
        upvoteButton.animate()
        
        delegate?.storyTableViewCellDidTouchUpvote(self, sender: sender)
    }
    
    @IBAction func commentButtonDidTouch(sender: AnyObject) {
        commentButton.animation = "pop"
        commentButton.force = 3
        commentButton.animate()
        
        delegate?.storyTableViewCellDidTouchComment(self, sender: sender)
    }
    
    func configureWithStory(story: AnyObject) {
        let title = story["title"] as? String
        let badge = story["badge"] as? String
        let userPortraitUrl = story["user_portrait_url"] as? String
        let userDisplayName = story["user_display_name"] as? String
        let userJob = story["user_job"] as? String
        let createdAt = story["created_at"] as? String
        let voteCount = story["vote_count"] as! Int
        let commentCount = story["comment_count"] as! Int
        let comment = story["comment"] as! String
        
        
        titleLabel.text = title
        badgeImageView.image = UIImage(named: "badge-" + badge!)
        avatarImageView.image = UIImage(named: "content-avatar-default")
        authorLabel.text = userDisplayName! + ", " + userJob!
        timeLabel.text = timeAgoSinceDate(dateFromString(createdAt!, "yyyy-MM-dd'T'HH:mm:ssZ"), true)
        upvoteButton.setTitle(toString(voteCount), forState: UIControlState.Normal)
        commentButton.setTitle(toString(commentCount), forState: UIControlState.Normal)
        
        if let commentTextView = commentTextView {
            commentTextView.text = comment
        }
    }
}
