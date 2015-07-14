//
//  ViewController.swift
//  Portofilo
//
//  Created by Martin on 15/7/11.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet var heroimg: UIImageView!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var topview: UIView!
    @IBOutlet var blurview: UIVisualEffectView!
    
    @IBOutlet var btnimg1: UIImageView!
    @IBOutlet var btnimg2: UIImageView!
    @IBOutlet var btnimg3: UIImageView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollview.contentSize = CGSizeMake(320, 1400)
        //将scrollview委托给其他
        scrollview.delegate = self
        scrollview.showsVerticalScrollIndicator = false
        
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println(scrollview.contentOffset.y)
        var scrolly = scrollview.contentOffset.y
        if(scrolly < 0){
        topview.transform = CGAffineTransformMakeScale(1-scrolly/100,1-scrolly/100)
        topview.frame.origin.y = scrolly/2
        }
        else if(scrolly > 0){
            blurview.alpha = 0+scrolly/150
            topview.frame.origin.y = -scrolly/5
        }
        else if (scrolly == 0){
            blurview.alpha = 0
        }
        
    }
    
    @IBAction func btn1(sender: AnyObject) {
    }
  
    @IBAction func btn2(sender: AnyObject) {
    }
    
    @IBAction func btn3(sender: AnyObject) {
        
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

