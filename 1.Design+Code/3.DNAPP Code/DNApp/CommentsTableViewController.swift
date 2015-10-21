//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/20.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController,CommentTableViewCellDelegate,StoryTableViewCellDelegate,ReplyViewControllerDelegate{
    var story:JSON!
    var comments:[JSON]!
    
    var transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //so we’re making it safe by adding the ?? fallback to an empty Array.
        comments = flattenComments(story["comments"].array ?? [])
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        //添加重刷VC功能
        refreshControl?.addTarget(self, action: "reloadStory", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    //add share button

    @IBAction func shareButtondidTouch(sender: AnyObject) {
        var title = story["title"].string ?? ""
        var url = story["url"].string ?? ""
        
        //activity VC调用
        let activityViewController = UIActivityViewController(activityItems: [title, url], applicationActivities: nil)
        activityViewController.setValue(title, forKey: "subject")
        activityViewController.excludedActivityTypes = [UIActivityTypeAirDrop]
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    // we’ll the story information in the first row.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifer = indexPath.row == 0 ? "StoryCell" : "CommentCell"
        //解读identifer
        let cell = tableView.dequeueReusableCellWithIdentifier(identifer) as UITableViewCell!
        //如果是stroycell则读storycell
        if let storyCell = cell as? StoryTableViewCell {
            storyCell.configureWithStory(story)
            //获取StoryCell的响应，方便处理点赞事件
            storyCell.delegate = self
        }
        //Story occupies the first row, that’s why we had to do -1.
        if let commentCell = cell as? CommentsTableViewCell {
            let comment = comments[indexPath.row - 1]
            commentCell.configureWithComment(comment)
            //获取commentCell的响应，方便处理点赞事件
            commentCell.delegate = self
        }
        
        return cell
    }
    
    //Mark:CommentTableViewCellDelegate
    
    func commentTableViewCellDidTouchUpvote(cell: CommentsTableViewCell) {
        if let token = LocalStore.getToken() {
            let indexPath = tableView.indexPathForCell(cell)!
            let comment = comments[indexPath.row-1]
            let commentId = comment["id"].int!
            DNService.upvoteCommentWithId(commentId, token: token, response: { (successful) -> () in
                // Do someting
            })
            
            LocalStore.saveUpvotedComment(commentId)
            cell.configureWithComment(comment)
        } else {
            performSegueWithIdentifier("LoginSegue", sender: self)
        }
    }
    
    func commentTableViewCellDidTouchComment(cell: CommentsTableViewCell) {
        if LocalStore.getToken() == nil {
            performSegueWithIdentifier("LoginSegue", sender: self)
        } else {
            performSegueWithIdentifier("ReplySegue", sender: cell)
        }
    }
    
    //Mark:StoryTableViewCellDelegate
    
    func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: AnyObject) {
        if let token = LocalStore.getToken() {
            let indexPath = tableView.indexPathForCell(cell)!
            let storyId = story["id"].int!
            DNService.upvoteStoryWithId(storyId, token: token, response: { (successful) -> () in
                
            })
            LocalStore.saveUpvotedStory(storyId)
            cell.configureWithStory(story)
        } else {
            performSegueWithIdentifier("LoginSegue", sender: self)
        }
    }
    
    func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: AnyObject) {
        if LocalStore.getToken() == nil {
            performSegueWithIdentifier("LoginSegue", sender: self)
        } else {
            performSegueWithIdentifier("ReplySegue", sender: cell)
        }
    }
    
    //Mark:ReplyViewControllerDelegate
    
    func replyViewControllerDidSend(controller: ReplayViewController) {
        reloadStory()
    }
    
    func reloadStory() {
        view.showLoading()
        DNService.storyForId(story["id"].int!, response: { (JSON) -> () in
            self.view.hideLoading()
            self.story = JSON["story"]
            self.comments = self.flattenComments(JSON["story"]["comments"].array ?? [])
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
        })
    }
    
    //Mark:PrepareForSegue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ReplySegue" {
            let toView = segue.destinationViewController as! ReplayViewController
            if let cell = sender as? CommentsTableViewCell {
                let indexPath = tableView.indexPathForCell(cell)!
                let comment = comments[indexPath.row - 1]
                toView.comment = comment
            }
            
            if let cell = sender as? StoryTableViewCell {
                toView.story = story
            }
            toView.delegate = self
            toView.transitioningDelegate = transitionManager
        }
    }
    

    
    // Helper
    
    func flattenComments(comments: [JSON]) -> [JSON] {
        let flattenedComments = comments.map(commentsForComment).reduce([], combine: +)
        return flattenedComments
    }
    
    func commentsForComment(comment: JSON) -> [JSON] {
        let comments = comment["comments"].array ?? []
        return comments.reduce([comment]) { acc, x in
            acc + self.commentsForComment(x)
        }
    }

}
