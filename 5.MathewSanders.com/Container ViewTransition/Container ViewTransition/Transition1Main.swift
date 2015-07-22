//
//  Transition1Main.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/22.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class Transition1Main: UIViewController {
let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToViewController3 (sender: UIStoryboardSegue){
        
    }
    
    @IBAction func btnpressed(sender: AnyObject) {
       

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            let controller = segue.destinationViewController as! UIViewController
        
            // 使用TransitionManager管理动画，不使用默认效果
            controller.transitioningDelegate = self.transitionManager
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.presentingViewController == nil ? UIStatusBarStyle.Default : UIStatusBarStyle.LightContent
    }


}
