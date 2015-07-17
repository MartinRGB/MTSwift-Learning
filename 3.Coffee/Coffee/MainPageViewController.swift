//
//  MainPageViewController.swift
//  Coffee
//
//  Created by Martin on 15/7/15.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet var navigation: UIImageView!
    @IBOutlet var sidebartext: UIImageView!
    @IBOutlet var cpbutton: UIButton!
    @IBOutlet var backbutton: UIButton!
    @IBOutlet var navbutton: UIButton!
    @IBOutlet var mainview: UIView!
    @IBOutlet var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollview.contentSize = CGSizeMake(300, 980)
        scrollview.showsVerticalScrollIndicator = false
        
        self.sidebartext.transform = CGAffineTransformMakeScale(0.7, 0.7)
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
    @IBAction func navbtnpressed(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
            self.mainview.transform = CGAffineTransformMakeScale(0.7, 0.7)
            self.navbutton.alpha = 0
            
            self.navigation.alpha = 0
            self.backbutton.alpha = 1
            self.cpbutton.alpha = 0
            self.mainview.frame.origin.x = 180
            self.scrollview.scrollEnabled = false
            
            self.sidebartext.frame.origin.x = 46
            self.sidebartext.transform = CGAffineTransformMakeScale(1, 1)
            
            }, completion: { finished in
        })
        
    }
    
    @IBAction func backbtn(sender: AnyObject) {
        
        UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .CurveEaseIn, animations: {
            self.mainview.transform = CGAffineTransformMakeScale(1, 1)
            self.navbutton.alpha = 1
            self.navigation.alpha = 1
            self.backbutton.alpha = 0
            self.cpbutton.alpha = 1
            self.mainview.frame.origin.x = 0
            self.scrollview.scrollEnabled = true
            
            self.sidebartext.frame.origin.x = 246
            self.sidebartext.transform = CGAffineTransformMakeScale(0.7, 0.7)
            
            
            }, completion: { finished in
        })

        
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }

}
