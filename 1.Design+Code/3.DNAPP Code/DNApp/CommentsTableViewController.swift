//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/20.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {
    var story = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.estimatedRowHeight = 140
        //tableView.rowHeight = UITableViewAutomaticDimension

        print(story)
    }


}
