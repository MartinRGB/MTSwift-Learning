//
//  FirstViewController.swift
//  123
//
//  Created by 1 on 15/7/2.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var scrollimg: UIImageView!
    
    @IBOutlet weak var scrollview: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollview.contentSize = CGSizeMake(342, 2600)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

