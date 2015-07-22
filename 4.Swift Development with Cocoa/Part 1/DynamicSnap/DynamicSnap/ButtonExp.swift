//
//  ButtonExp.swift
//  DynamicSnap
//
//  Created by Martin on 15/7/19.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class ButtonExp: UIViewController {
    
    @IBOutlet weak var dribbbleview: UIImageView!
    
    var dynamicAnimator:UIDynamicAnimator?
    var nr1: UIDynamicItemBehavior!
    var nr2: UIDynamicItemBehavior!
    var nr3: UIDynamicItemBehavior!
    var nr4: UIDynamicItemBehavior!
    
    var snap1:UISnapBehavior?
    var snap2:UISnapBehavior?
    var snap3:UISnapBehavior?
    var snap4:UISnapBehavior?
    
    let btn1 = UIImageView()
    let btn2 = UIImageView()
    let btn3 = UIImageView()
    let btn4 = UIImageView()
    var center = UIImageView()
    var blackalpha = UIImageView()
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //set the UIImage&Imageview
        btn1.image = UIImage(named: "Btn1.png")
        btn2.image = UIImage(named: "Btn2.png")
        btn3.image = UIImage(named: "Btn3.png")
        btn4.image = UIImage(named: "Btn4.png")
        center.image = UIImage(named:"Center.png")
        blackalpha.image = UIImage(named:"Blackalpha.png")
        
        btn1.alpha = 0
        btn2.alpha = 0
        btn3.alpha = 0
        btn4.alpha = 0
        center.alpha = 0
        blackalpha.alpha = 0
        center.transform = CGAffineTransformMakeScale(2, 2)
        
        self.view.addSubview(blackalpha)
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        self.view.addSubview(btn4)
        self.view.addSubview(center)
        
        //add DynamicAnimator
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view);
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func longpressed(sender: AnyObject) {
        //set 4 popup point
        let lpress = sender as! UILongPressGestureRecognizer
        var point = lpress.locationInView(self.view)
        var point1 = CGPointMake(point.x-77, point.y-17)
        var point2 = CGPointMake(point.x-39, point.y-72)
        var point3 = CGPointMake(point.x+24, point.y-72)
        var point4 = CGPointMake(point.x+67, point.y-17)
        
        center.frame = CGRectMake(point.x-28, point.y-28, 54, 56)
        println(point)
        
        
        UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
            self.center.alpha = 1
            }, completion: {finished in})


        if sender.state == UIGestureRecognizerState.Began{
    
            //no rotation make effect smooth
            nr1 = UIDynamicItemBehavior(items: [self.btn1])
            nr1.allowsRotation = false
            nr2 = UIDynamicItemBehavior(items: [self.btn2])
            nr2.allowsRotation = false
            nr3 = UIDynamicItemBehavior(items: [self.btn3])
            nr3.allowsRotation = false
            nr4 = UIDynamicItemBehavior(items: [self.btn4])
            nr4.allowsRotation = false
            
            blackalpha.frame = CGRectMake(0, 0, 320, 568)
            btn1.frame = CGRectMake(point.x, point.y, 48, 48)
            btn2.frame = CGRectMake(point.x, point.y, 48, 48)
            btn3.frame = CGRectMake(point.x, point.y, 48, 48)
            btn4.frame = CGRectMake(point.x, point.y, 48, 48)
            
            
            //alpha fade in
            UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.btn1.alpha = 1
                self.btn2.alpha = 1
                self.btn3.alpha = 1
                self.btn4.alpha = 1
                self.center.alpha = 1
                self.blackalpha.alpha = 0.2
            }, completion: {finished in})
           
            self.dynamicAnimator?.removeAllBehaviors()
            //snap effect
            self.snap1 = UISnapBehavior(item:self.btn1 ,snapToPoint:point1)
            self.snap2 = UISnapBehavior(item:self.btn2 ,snapToPoint:point2)
            self.snap3 = UISnapBehavior(item:self.btn3 ,snapToPoint:point3)
            self.snap4 = UISnapBehavior(item:self.btn4 ,snapToPoint:point4)
            
            
            
            self.dynamicAnimator?.addBehavior(self.snap1)
            self.dynamicAnimator?.addBehavior(self.snap2)
            self.dynamicAnimator?.addBehavior(self.snap3)
            self.dynamicAnimator?.addBehavior(self.snap4)
            
        }

         if sender.state == UIGestureRecognizerState.Ended{
            
            
            
            
            //alpha fade out
            UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.btn1.alpha = 0
                self.btn2.alpha = 0
                self.btn3.alpha = 0
                self.btn4.alpha = 0
                self.center.alpha = 0
                self.blackalpha.alpha = 0
                }, completion: {finished in})
            
            self.dynamicAnimator?.removeAllBehaviors()
            // no rotation make smooth
            self.dynamicAnimator?.addBehavior(nr1)
            self.dynamicAnimator?.addBehavior(nr2)
            self.dynamicAnimator?.addBehavior(nr3)
            self.dynamicAnimator?.addBehavior(nr4)
            //snap back
            self.snap1 = UISnapBehavior(item:self.btn1 ,snapToPoint:point)
            self.snap2 = UISnapBehavior(item:self.btn2 ,snapToPoint:point)
            self.snap3 = UISnapBehavior(item:self.btn3 ,snapToPoint:point)
            self.snap4 = UISnapBehavior(item:self.btn4 ,snapToPoint:point)
            
            
            self.dynamicAnimator?.addBehavior(self.snap1)
            self.dynamicAnimator?.addBehavior(self.snap2)
            self.dynamicAnimator?.addBehavior(self.snap3)
            self.dynamicAnimator?.addBehavior(self.snap4)
        }
        
        
        
    }
    
    
    
    
    
    

}
