//
//  SecondViewController.swift
//  123
//
//  Created by 1 on 15/7/2.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var articlelist: UIImageView!
    
    @IBOutlet weak var detailbtn: UIButton!

    @IBOutlet weak var backbtn: UIButton!
    
    @IBOutlet weak var sidebar: UIImageView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet var nav: UIImageView!
    
    @IBOutlet var hambtn: UIButton!
    
    var previousTableViewYOffset : CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollview.contentSize = CGSizeMake(290,1220)
        scrollview.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.nav.frame.origin.y = 0
        scrollview.contentOffset.y = 0
        
    }
    
    
    
    //sidebar
    @IBAction func pullout(sender: AnyObject) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
        self.sidebar.frame.origin.x = -100
        self.backbtn.frame.origin.x = 180
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
    
    @IBAction func detailbutton(sender: AnyObject) {
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
        if(scrollview.contentOffset.y > 100 && scrollView.contentOffset.y < 600){
            if(scrollview.contentOffset.y < previousTableViewYOffset)
            {
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                    self.tabBarController?.tabBar.frame.origin.y = 520
                    self.nav.frame.origin.y = 0
                    self.hambtn.frame.origin.y = 14
                    }, completion: { finished in
                })
                
                
                
            }
            else{
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                    self.tabBarController?.tabBar.frame.origin.y = 568
                    self.nav.frame.origin.y = -53
                    self.hambtn.frame.origin.y = -39
                    }, completion: { finished in
                })
                
            }
        }
        else{
            
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                self.tabBarController?.tabBar.frame.origin.y = 520
                self.nav.frame.origin.y = 0
                self.hambtn.frame.origin.y = 14
                }, completion: { finished in
            })
            
        }
        
        
        
    }

}

