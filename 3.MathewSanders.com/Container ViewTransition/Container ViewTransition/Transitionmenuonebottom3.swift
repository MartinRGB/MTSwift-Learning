//
//  Transitionmenuonebottom3.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/25.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class Transitionmenuonebottom3: UIViewController {

    @IBOutlet weak var l1: UIImageView!
    @IBOutlet weak var l2: UIImageView!
    @IBOutlet weak var l3: UIImageView!
    @IBOutlet weak var l4: UIImageView!
    @IBOutlet weak var l5: UIImageView!
    @IBOutlet weak var l6: UIImageView!
    
    @IBOutlet weak var blurview: UIVisualEffectView!
    let transitionManager = Transition2Menu3TransitionManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.transitioningDelegate = transitionManager
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        blurview.alpha = 0
        let options = UIViewAnimationOptions.CurveLinear
        
        
        
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
            
            self.blurview.alpha = 0.95
            
            }, completion: { finished in
                
                
        })
        
        
    }

}
