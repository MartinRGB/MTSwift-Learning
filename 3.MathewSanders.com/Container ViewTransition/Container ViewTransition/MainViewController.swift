//
//  mainViewController.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/26.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // create instance of our custom transition manager
    let transitionManager = MenuTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.transitionManager.sourceViewController = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // set transition delegate for our menu view controller
        let menu = segue.destinationViewController as! MenuViewController
        menu.transitioningDelegate = self.transitionManager
        self.transitionManager.menuViewController = menu
        
    }
    
    @IBAction func unwindToMainViewController000 (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
