//
//  DetailViewController.swift
//  lesson1
//
//  Created by Martin on 15/7/2.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController,UIScrollViewDelegate {


    @IBOutlet var btn: UIButton!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var text: UIImageView!
    @IBOutlet var nav: UIImageView!
    var previousTableViewYOffset : CGFloat?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollview.contentSize = CGSizeMake(320, 1567)
        
        scrollview.delegate = self
        self.tabBarController?.tabBar.hidden = true
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
    
    //用按钮触发push返回
    @IBAction func doback(sender: AnyObject) {
        
        self.navigationController!.popViewControllerAnimated(true)
        
        self.tabBarController?.tabBar.hidden = false
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
            self.tabBarController?.tabBar.frame.origin.y = 520
            }, completion: { finished in
        })
    }
    
    //scroll to hide and show
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        previousTableViewYOffset = scrollview.contentOffset.y
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        println(scrollview.contentOffset.y)
        if(scrollview.contentOffset.y > 100){
            if(scrollview.contentOffset.y < previousTableViewYOffset)
            {
                println("0")
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                    self.nav.frame.origin.y = 0
                    self.btn.frame.origin.y = 15
                    }, completion: { finished in
                })
                
                
            }
            else{
                println("1")
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                    self.nav.frame.origin.y = -53
                    self.btn.frame.origin.y = -38
                    }, completion: { finished in
                })
                
            }
        }
        
        
    }
    

}
