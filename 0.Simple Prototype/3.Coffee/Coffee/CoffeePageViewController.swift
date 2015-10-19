//
//  CoffeePageViewController.swift
//  Coffee
//
//  Created by Martin on 15/7/15.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class CoffeePageViewController: UIViewController {

    @IBOutlet var cardview: UIView!
    
    @IBOutlet var dark: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.cardview.transform = CGAffineTransformMakeScale(0.4, 0.4)
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
    
    @IBAction func detailbtn(sender: AnyObject) {
        
        self.cardview.frame.origin.y = -600
            
        UIView.animateWithDuration(0.65, delay:0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            
            self.cardview.transform = CGAffineTransformMakeScale(1, 1)
            self.cardview.frame.origin.y = 12
            self.dark.alpha = 1
            
            }, completion: { finished in
        
        })

        
    }
    
    @IBAction func dissmissbtn(sender: AnyObject) {
        
        UIView.animateWithDuration(0.55, delay:0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
            
            self.cardview.transform = CGAffineTransformMakeScale(0.8, 0.8)
            self.cardview.frame.origin.y = 612
            self.dark.alpha = 0
            
            }, completion: { finished in
                self.cardview.frame.origin.y = -600
                
        })
        
        
    }
    

}
