//
//  Transitionmenuonebottom2.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/25.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class Transitionmenuonebottom2: UIViewController {

    @IBOutlet weak var blurview: UIVisualEffectView!
    
    let transitionManager = Transition2Menu2TransitionManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        //加载自定义segue动画设置
        self.transitioningDelegate = transitionManager
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        blurview.alpha = 0
        let options = UIViewAnimationOptions.CurveLinear
        
        
        
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
           
            self.blurview.alpha = 0.95
            
            }, completion: { finished in
                
                
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
