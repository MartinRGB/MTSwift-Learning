//
//  StoryTableViewCell.swift
//  DNApp
//
//  Created by KingMartin on 15/10/19.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

protocol StoryTableViewCellDelegate:class{
    func storyTableViewCellDidTouchUpvote(cell:StoryTableViewCell,sender:AnyObject)
    func storyTableViewCellDidTouchComment(cell:StoryTableViewCell,sender:AnyObject)
}

class StoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var upvotebutton: SpringButton!
    @IBOutlet weak var commentbutton: SpringButton!
    @IBOutlet weak var commentTextView: AutoTextView!
    
    weak var delegate:StoryTableViewCellDelegate?
    
    @IBAction func upvoteButtonDidTouch(sender: AnyObject) {
        upvotebutton.animation = "pop"
        upvotebutton.force = 1
        upvotebutton.curve = "easeInOut"
        upvotebutton.duration = 0.8
        upvotebutton.animate()
        delegate?.storyTableViewCellDidTouchUpvote(self, sender: sender)
    }
    
    @IBAction func commentButtonDidTouch(sender: AnyObject) {
        commentbutton.animation = "pop"
        commentbutton.force = 1
        commentbutton.curve = "easeInOut"
        commentbutton.duration = 0.8
        commentbutton.animate()
        delegate?.storyTableViewCellDidTouchComment(self, sender: sender)
    }
    
    func configureWithStory(story:AnyObject){
        let title = story["title"] as! String
        let badge = story["badge"] as! String
        let usePortrailUrl = story["user_display_name"] as! String
        let userDisplayName = story["user_display_name"] as! String
        let userJob = story["user_job"] as! String
        let createdAt = story["created_at"] as! String
        let voteCount = story["vote_count"] as! Int
        let commentCount = story["comment_count"] as! Int
        
        titleLabel.text = title
        //a prefix badge- was added to match the name.
        badgeImageView.image = UIImage(named:"badge-" + badge)
        avatarImageView.image = UIImage(named: "content-avatar-default")
        authorLabel.text = userDisplayName + ", " + userJob
        //The first function dateFromString returns a NSDate, which then goes through timeAgoSinceDate, using a bunch of calculations to get a String back, which is the shortened “time ago” instead of the unreadable
        timeLabel.text = timeAgoSinceDate(dateFromString(createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
        upvotebutton.setTitle(String(voteCount), forState: UIControlState.Normal)
        commentbutton.setTitle(String(commentCount), forState: UIControlState.Normal)
        
        //since commentTextView doesn’t exist in the Stories screen, we have to make sure that we’re only applying to it when it exists.
        
        let comment = story["comment"] as! String
        if let commentTextView = commentTextView {
            commentTextView.text = comment
        }

        
    }

}
