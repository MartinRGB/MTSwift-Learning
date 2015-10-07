//
//  MainViewController.swift
//  6.Expanding-Cells
//
//  Created by KingMartin on 15/10/1.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit


//global variable
var passindex : Int!

class MainViewController: UITableViewController,TransitionManagerPresentingVC {
    var selectedIndexPath: NSIndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UITableViewDelegate
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
    }
    
    //MARK:UITableViewDelegate - 选中后的效果
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedIndexPath = indexPath
        
        //获取int值
        var intindex : Int! = indexPath.row
        //global variable
        passindex = intindex
        
        //让SB Identifier赋值给controller
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        //展现动画
        presentViewController(controller, animated: true, completion: nil)

        
        if(intindex == 1)
        {
            //code here
        }
        else
        {
            //code here
        }
        
    }
    
    //MARK: Know which row happened the transition
    func transitionManagerTargetViewForTransition(transition:TransitionManager)-> UIView!{
        if let indexPath = selectedIndexPath{
            return tableView.cellForRowAtIndexPath(indexPath)
        }
        else{
            return nil
        }
    }
}
