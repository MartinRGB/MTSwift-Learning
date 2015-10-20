//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/20.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {
    var story:JSON!
    var comments:JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comments = story["comments"]
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
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
        }
        //Story occupies the first row, that’s why we had to do -1.
        if let commentCell = cell as? CommentsTableViewCell {
            let comment = comments[indexPath.row - 1]
            commentCell.configureWithComment(comment)
        }
        
        return cell
    }



}
