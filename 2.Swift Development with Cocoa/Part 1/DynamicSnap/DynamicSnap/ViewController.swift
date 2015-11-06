//
//  ViewController.swift
//  DynamicSnap
//
//  Created by Martin on 15/7/17.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var naomisorz: UIImageView!
    
    var dynamicAnimator:UIDynamicAnimator?
    var snap:UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapped(sender: AnyObject) {
        //获取点击位置
        let tap = sender as! UITapGestureRecognizer
        let point = tap.locationInView(self.view)
        
        //删除吸附，加入新的
        self.dynamicAnimator?.removeAllBehaviors()
        self.snap = UISnapBehavior(item:self.naomisorz ,snapToPoint:point)
        self.dynamicAnimator?.addBehavior(self.snap!)
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }

}

