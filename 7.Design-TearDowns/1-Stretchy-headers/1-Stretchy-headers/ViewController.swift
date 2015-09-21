//
//  ViewController.swift
//  1-Stretchy-headers
//
//  Created by KingMartin on 15/9/21.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

//autolayout can be used for following scroll

private let mtTableHeaderHeight:CGFloat = 264
private let mtTableHeaderCut:CGFloat = 44.0
private let effectiveHeight = mtTableHeaderHeight - mtTableHeaderCut/2
var headerMasklayer:CAShapeLayer!

var headerView:UIView!

//data
let items = [NewsItem(category: .designernews,summary:"CSS Frontend Frameworks: The Best 10 for Modern Web Design"),NewsItem(category: .github,summary:"Material-Animations"),NewsItem(category: .alistapart,summary:"Evaluating Ideas"),NewsItem(category: .medium,summary:"How To Eliminate 90% Of Your Regret And Anxiety By Thinking Like A Roman Emperor"),NewsItem(category: .sidebario,summary:"Why you should look at Material Design for your next project."),NewsItem(category: .producthunt,summary:"Monese"),NewsItem(category: .designernews,summary:"CSS Frontend Frameworks: The Best 10 for Modern Web Design"),NewsItem(category: .designernews,summary:"CSS Frontend Frameworks: The Best 10 for Modern Web Design"),NewsItem(category: .designernews,summary:"CSS Frontend Frameworks: The Best 10 for Modern Web Design"),NewsItem(category: .designernews,summary:"CSS Frontend Frameworks: The Best 10 for Modern Web Design"),]


class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //resize the cells automatically according to our Auto Layout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        
        tableView.addSubview(headerView)
        
        //table view cell上移
        //contentInset是scrollview的contentview的顶点相对于scrollview的位置
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        //contentOffset是scrollview当前显示区域顶点相对于frame顶点的偏移量
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        //Mask added
        headerMasklayer = CAShapeLayer()
        headerMasklayer.fillColor = UIColor.blackColor().CGColor
        headerView.layer.mask = headerMasklayer
        
        //moved the call to updateHeaderView() to the bottom so we can setup the masking layer before we update.
        updateHeaderView()
        
        

    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x:0,y:-effectiveHeight,width:tableView.bounds.width,height:mtTableHeaderHeight)
        //滑动位置超过图片位置
        if tableView.contentOffset.y < -effectiveHeight{
            //下移
            headerRect.origin.y = tableView.contentOffset.y
            //扩大
            headerRect.size.height = -tableView.contentOffset.y + mtTableHeaderCut/2
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height-mtTableHeaderCut))
        headerMasklayer?.path = path.CGPath
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Hide the Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - UITableViewDataSource
    
    //create 5 rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! newsitemcell
        cell.newsItem = item
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    //fix the UITableViewAutomaticDimension
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }

    
    
}

