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



//需要获取FloatingmenuController的Delegate
class MainViewController: UITableViewController,TransitionManagerPresentingVC,FloatingMenuControllerDelegate {
    var selectedIndexPath: NSIndexPath?
    let fab = FloatingButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:add the FAB
        if let image = UIImage(named: "icon-add.png"){
            fab.setImage(image, forState: .Normal)
        }
        fab.setTitleColor(UIColor.blueColor(), forState: .Normal)
        fab.frame = CGRectMake(0.9*self.view.bounds.width - 50, 0.94*self.view.bounds.height-50, 50, 50)
        //Way to add target for btn
        fab.addTarget(self, action: "FABonclick:", forControlEvents: UIControlEvents.TouchUpInside)
        //Pin The Fab,disable the FAB scroll effect
        self.navigationController!.view.addSubview(fab)
        
        
        // Do any additional setup after loading the view.
        
        //Init animation
        self.tableView.alpha = 0
        self.tableView.reloadData()
        
        let diff:Double = 0.05
        let tableHeight:CGFloat = self.tableView.bounds.size.height
        let cells:NSArray = self.tableView.visibleCells
        
        for var a = 0;a < cells.count; a++ {
            let cell:UITableViewCell = cells.objectAtIndex(a) as! UITableViewCell
            if(cell.isKindOfClass(UITableViewCell)){
                cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
                
            }
        }
        
        //Now Animation(Chained Delay)
        self.tableView.alpha = 1.0
        self.fab.transform = CGAffineTransformMakeScale(0, 0)
        
        var index = 0
        
        for b in cells{
            let cell: UITableViewCell = b as! UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                self.fab.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: nil)
            
            index += 1
        }
                
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
    
    //FAB + On Click
    func FABonclick(sender:AnyObject){
        let controller = FloatingMenuController(fromView: sender as! UIButton)
        
        controller.delegate = self
        
        //button image
        controller.buttonItems = [
            FloatingButton(image:UIImage(named: "icon-add")),
            FloatingButton(image:UIImage(named: "model-008")),
            FloatingButton(image:UIImage(named: "model-007")),
            FloatingButton(image:UIImage(named: "model-006")),
            FloatingButton(image:UIImage(named: "model-005")),
            FloatingButton(image:UIImage(named: "model-004"))
        ]
        //titlte
        controller.labelTitles = [
            "New Contact",
            "Heidi Hernandez",
            "Neil Ross",
            "Elijah Woods",
            "Bella Douglas",
            "Tommy Cloucy"
        ]
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    //Menu On click
    func floatingMenuController(controller: FloatingMenuController, didTapOnButton button: UIButton, atIndex index: Int) {
        print("tapped index \(index)")
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
