//
//  FirstViewController.swift
//  123
//
//  Created by 1 on 15/7/2.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit
class FirstViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var scrollimg: UIImageView!
    @IBOutlet var nav: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    var previousTableViewYOffset : CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollview.contentSize = CGSizeMake(290, 2220)
        scrollview.delegate = self
        
        //define the tabbar color
        let tabBar = self.tabBarController?.tabBar;
        tabBar!.backgroundColor = UIColor(red: 243, green: 240, blue: 236, alpha: 1)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.nav.frame.origin.y = 0
        scrollview.contentOffset.y = 0
      
    }
    
    /*
    func setNavBar()
    {
        navBar.frame=CGRectMake(0, 0, 320, 153)
        navBar.backgroundColor=(UIColor.redColor())
        self.view.addSubview(navBar)
    }*/
    
    
    //btn to hide
    @IBAction func imgbtn(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseIn, animations: {
            self.tabBarController?.tabBar.frame.origin.y = 568
            }, completion: { finished in
        })

    }
    
    
    
    //scroll to hide and show
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        previousTableViewYOffset = scrollview.contentOffset.y
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        println(scrollview.contentOffset.y)
        if(scrollview.contentOffset.y > 100 && scrollView.contentOffset.y < 1500){
           if(scrollview.contentOffset.y < previousTableViewYOffset)
           {
            
               UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                   self.tabBarController?.tabBar.frame.origin.y = 520
                   self.nav.frame.origin.y = 0
                   }, completion: { finished in
               })
            

           }
           else{
            
                 UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                   self.tabBarController?.tabBar.frame.origin.y = 568
                    self.nav.frame.origin.y = -53
                   }, completion: { finished in
               })
            
            
            }
        }
        else
        {
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                self.nav.frame.origin.y = 0
                self.tabBarController?.tabBar.frame.origin.y=520
                }, completion: { finished in
            })
            
        }
        
        
        
    }

    
  
}

