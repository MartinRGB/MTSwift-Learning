//
//  mainViewController.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/26.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class topmainViewController: UIViewController {

    var transitionManager = transition3TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let menu = segue.destinationViewController as! slidemenuViewController
        menu.transitioningDelegate = self.transitionManager
    }
    
    @IBAction func unwindtomenuViewController (sender:UIStoryboardSegue){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
