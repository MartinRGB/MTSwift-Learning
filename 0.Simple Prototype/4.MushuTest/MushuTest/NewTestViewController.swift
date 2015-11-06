//
//  NewTestViewController.swift
//  MushuTest
//
//  Created by KingMartin on 15/11/6.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class NewTestViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var blurimageView: ANBlurredImageView!
    
    
    @IBOutlet weak var scrollView1: UIScrollView!
    
    @IBOutlet weak var scrollView2: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        scrollView1.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height*1.795+1200)
        scrollView1.delegate = self
        scrollView1.showsVerticalScrollIndicator = false
        
        scrollView2.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height*1.795+1200)
        scrollView2.delegate = self
        scrollView2.showsVerticalScrollIndicator = false
        
        blurimageView.blurAmount = 1
        blurimageView.framesCount = 20
        blurimageView.tintColor = UIColor.clearColor()
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView1.contentOffset.y = scrollView2.contentOffset.y
    }
    
    
    @IBAction func btntapped(sender: AnyObject) {
        blurimageView.blurInAnimationWithDuration(0.2)
        
    }
    @IBAction func unblurtapped(sender: AnyObject) {
        blurimageView.blurOutAnimationWithDuration(0.2)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
