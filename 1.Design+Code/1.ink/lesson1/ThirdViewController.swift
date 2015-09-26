//
//  ThirdViewController.swift
//  lesson1
//
//  Created by Martin on 15/7/6.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet var scrollimg: UIImageView!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var nav: UIImageView!
    var previousTableViewYOffset : CGFloat?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.contentSize = CGSizeMake(290,1290)
        scrollview.delegate = self
        // Do any additional setup after loading the view.
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func detailbtn(sender: AnyObject) {
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
        
        
        print(scrollview.contentOffset.y)
        if(scrollview.contentOffset.y > 100 && scrollView.contentOffset.y < 650){
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
        else{
            
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                self.tabBarController?.tabBar.frame.origin.y = 520
                self.nav.frame.origin.y = 0
                }, completion: { finished in
            })
            
        }
        
        
    }

}
