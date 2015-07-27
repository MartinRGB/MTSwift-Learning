//
//  Transitionmenutwodetail.swift
//  Container ViewTransition
//
//  Created by Martin on 15/7/25.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    //调用转场轮子
    let transitionManager = MenuTransitionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //指明soureViewCOntroller为此VC/bottom
         self.transitionManager.sourceViewController = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //segue转场受TransitionManager控制
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let menu = segue.destinationViewController as! MenuViewController
        menu.transitioningDelegate = self.transitionManager
       
        //使用transitionManager中的MenuViewController
         self.transitionManager.menuViewController = menu
    }
    
    
    @IBAction func unwindToViewController5 (sender: UIStoryboardSegue){
        
        //manually dismiss the screen ，手动取消
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}
