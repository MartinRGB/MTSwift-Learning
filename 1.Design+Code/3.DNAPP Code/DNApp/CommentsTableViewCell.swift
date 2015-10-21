//
//  CommentsTableViewCell.swift
//  DNApp
//
//  Created by KingMartin on 15/10/20.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

protocol CommentTableViewCellDelegate:class{
    func commentTableViewCellDidTouchUpvote(cell:CommentsTableViewCell)
    func commentTableViewCellDidTouchComment(cell:CommentsTableViewCell)
}

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var identView: UIView!
    @IBOutlet weak var avatarLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var avatarImageView: AsyncImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var upvoteButton: SpringButton!
    @IBOutlet weak var replyButton: SpringButton!
    @IBOutlet weak var commentTextView: AutoTextView!
    
    weak var delegate: CommentTableViewCellDelegate?
    
    
    @IBAction func upvoteButtonDidTouch(sender: AnyObject) {
        delegate?.commentTableViewCellDidTouchUpvote(self)
        upvoteButton.animation = "pop"
        upvoteButton.force = 1
        upvoteButton.curve = "easeInOut"
        upvoteButton.duration = 0.8
        upvoteButton.animate()
        SoundPlayer.play("upvote.wav")
    }
    
    @IBAction func replyButtonDidTouch(sender: AnyObject) {
        delegate?.commentTableViewCellDidTouchComment(self)
        replyButton.animation = "pop"
        replyButton.force = 1
        replyButton.curve = "easeInOut"
        replyButton.duration = 0.8
        replyButton.animate()
    }
    
    func configureWithComment(comment: JSON) {
        let userPortraitUrl = comment["user_portrait_url"].string
        let userDisplayName = comment["user_display_name"].string!
        let userJob = comment["user_job"].string ?? ""
        let createdAt = comment["created_at"].string!
        let voteCount = comment["vote_count"].int!
        let body = comment["body"].string!
        
        avatarImageView.url = userPortraitUrl?.toURL()
        avatarImageView.image = UIImage(named: "content-avatar-default")
        authorLabel.text = userDisplayName + ", " + userJob
        timeLabel.text = timeAgoSinceDate(dateFromString(createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
        upvoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
        commentTextView.text = body
        
        //comment的响应变化
        let commentId = comment["id"].int!
        if LocalStore.isCommentUpvoted(commentId) {
            upvoteButton.setImage(UIImage(named: "icon-upvote-active"), forState: UIControlState.Normal)
            upvoteButton.setTitle(String(voteCount+1), forState: UIControlState.Normal)
        } else {
            upvoteButton.setImage(UIImage(named: "icon-upvote"), forState: UIControlState.Normal)
            upvoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
        }
        //Comment的层次变化，通过控制constraint实现
        let depth = comment["depth"].int! > 4 ? 4 : comment["depth"].int!
        if depth > 0 {
            avatarLeftConstraint.constant = CGFloat(depth) * 20 + 25
            separatorInset = UIEdgeInsets(top: 0, left: CGFloat(depth) * 20 + 15, bottom: 0, right: 0)
        } else {
            avatarLeftConstraint.constant = 10
            separatorInset = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        }
    }
}
