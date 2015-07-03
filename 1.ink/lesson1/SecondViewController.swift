//
//  SecondViewController.swift
//  123
//
//  Created by 1 on 15/7/2.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var articlelist: UIImageView!
    
    @IBOutlet weak var detailbtn: UIButton!

    @IBOutlet weak var backbtn: UIButton!
    
    @IBOutlet weak var sidebar: UIImageView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollview.contentSize = CGSizeMake(344,1500)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pullout(sender: AnyObject) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
        self.sidebar.frame.origin.x = -100
        self.backbtn.frame.origin.x = 250
            }, completion: { finished in
        })
    
    }

    @IBAction func pushback(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
            self.sidebar.frame.origin.x = -327
            self.backbtn.frame.origin.x = 400
            }, completion: { finished in
        })
        
    }

}

