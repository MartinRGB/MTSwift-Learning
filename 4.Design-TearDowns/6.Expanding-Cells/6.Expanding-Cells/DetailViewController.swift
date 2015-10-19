//
//  DetailViewController.swift
//  6.Expanding-Cells
//
//  Created by KingMartin on 15/10/1.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,TransitionManagerPresentedVC {
    
    @IBOutlet weak var uiimageview: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var navigationBarSnapShot:UIView!
    var navigationBarHeight:CGFloat = 0

    //获取TransitionManager转场方式
    let transition = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //加入TransitionManager
        transitioningDelegate = transition
        // Do any additional setup after loading the view.
        print("\(passindex)")
        
        if passindex == 0 {
            uiimageview.image = UIImage(named: "Page2")
        }
        else if passindex == 1{
            uiimageview.image = UIImage(named: "inbox")
        }
        else{
            uiimageview.image = UIImage(named: "Page0")
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if navigationBarSnapShot != nil {
            navigationBarSnapShot.frame.origin.y = -navigationBarHeight
            scrollView.addSubview(navigationBarSnapShot)
            
       
        }
    }
    
    // MARK: UIScrollViewDelegate
    
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -navigationBarHeight/2 {
            print ("1")
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !isBeingDismissed() {
            navigationBarSnapShot.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: view.bounds.width, height: -scrollView.contentOffset.y)
        }
        //status bar
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            [self]
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }

    
    
    //status bar transition
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if scrollView.contentOffset.y < -navigationBarHeight/2 {
            return .LightContent
        }
        return .Default
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closebtn(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    func transitionManager(transition: TransitionManager, navigationBarSnapshot: UIView) {
        self.navigationBarSnapShot = navigationBarSnapshot
        self.navigationBarHeight = navigationBarSnapshot.frame.height
    }

}
