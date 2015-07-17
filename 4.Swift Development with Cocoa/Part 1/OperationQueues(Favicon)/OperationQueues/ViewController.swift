//
//  ViewController.swift
//  OperationQueues
//
//  Created by Martin on 15/7/18.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //字符串数组，网站个数
    let hosts = ["github.com","ui.cn","medium.com","ui8.net","behance.com","invisionapp.com","usepanda.com","dribbble.com","baidu.com"]
    //NSOperationQueue，交给此类显示的FaviconTableViewCell个数
    let queue = NSOperationQueue()
    //只有一个小节，小节中行数等于hosts数据中网站个数
    func numberOfSectionsInTableView(tableView:UITableView!) ->Int{
        return 1
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int{
        return hosts.count
    }
    //让FaviconTableViewCell作为表格视图单元格，对应正确网站，使用dequeueReusableCellWithIdentifier方法提取单元格，然后用hosts数组创建NSURL提供给它
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath)-> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("FaviconCell") as! FaviconTableViewCell
        var host = hosts[indexPath.row]
        var url = NSURL(string:"http://\(host)/favicon.ico")
        cell.operationQueue = queue
        cell.url = url
        return cell
    }

}

