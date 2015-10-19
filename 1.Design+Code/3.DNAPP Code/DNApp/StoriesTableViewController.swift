//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/19.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController,StoryTableViewCellDelegate {

    @IBAction func menuButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
    }
    
    @IBAction func loginButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("LoginSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
           }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell
        
        cell.titleLabel.text = "Learn iOS Design and Xcode"
        cell.badgeImageView.image = UIImage(named: "badge-apple")
        cell.avatarImageView.image = UIImage(named: "content-avatar-default")
        cell.authorLabel.text = "Meng To, designer and coder"
        cell.timeLabel.text = "5m"
        cell.upvotebutton.setTitle("59", forState: UIControlState.Normal)
        cell.commentbutton.setTitle("32", forState: UIControlState.Normal)

        cell.delegate = self
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("WebSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func storyTableViewCellDIdTouchComment(cell: StoryTableViewCell, sender: AnyObject) {
        performSegueWithIdentifier("CommentsSegue", sender: self)
    }
    
    func storyTableViewCellDIdTouchUpvote(cell: StoryTableViewCell, sender: AnyObject) {
        //
    }

}
