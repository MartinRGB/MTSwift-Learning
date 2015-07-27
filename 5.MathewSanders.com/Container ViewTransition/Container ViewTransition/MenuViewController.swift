//
//  Transitionmenutwobottom.swift
//  Container ViewTransition
//
//  Created by Martin on 15/7/25.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var l1: UIImageView!
    @IBOutlet var l2: UIImageView!
    @IBOutlet var l3: UIImageView!
    @IBOutlet var l4: UIImageView!
    @IBOutlet var l5: UIImageView!
    @IBOutlet var l6: UIImageView!
    
    
    
    let transitionManager2 = MenuTransitionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = transitionManager2

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
