//
//  StoryTableViewCell.swift
//  DNApp
//
//  Created by KingMartin on 15/10/19.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

protocol StoryTableViewCellDelegate:class{
    func storyTableViewCellDIdTouchUpvote(cell:StoryTableViewCell,sender:AnyObject)
    func storyTableViewCellDIdTouchComment(cell:StoryTableViewCell,sender:AnyObject)
}

class StoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var upvotebutton: SpringButton!
    @IBOutlet weak var commentbutton: SpringButton!
    weak var delegate:StoryTableViewCellDelegate?
    
    @IBAction func upvoteButtonDidTouch(sender: AnyObject) {
        upvotebutton.animation = "pop"
        upvotebutton.force = 1
        upvotebutton.curve = "easeInOut"
        upvotebutton.duration = 0.8
        upvotebutton.animate()
        delegate?.storyTableViewCellDIdTouchUpvote(self, sender: sender)
    }
    
    @IBAction func commentButtonDidTouch(sender: AnyObject) {
        commentbutton.animation = "pop"
        commentbutton.force = 1
        commentbutton.curve = "easeInOut"
        commentbutton.duration = 0.8
        commentbutton.animate()
        delegate?.storyTableViewCellDIdTouchComment(self, sender: sender)
    }

}
