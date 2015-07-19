//
//  ButtonExp.swift
//  DynamicSnap
//
//  Created by Martin on 15/7/19.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class ButtonExp: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btn1.image = UIImage(named: "Btn1.png")
        btn2.image = UIImage(named: "Btn2.png")
        btn3.image = UIImage(named: "Btn3.png")
        btn4.image = UIImage(named: "Btn4.png")
        
        btn1.alpha = 0
        btn2.alpha = 0
        btn3.alpha = 0
        btn4.alpha = 0
        
        
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        self.view.addSubview(btn4)
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view);
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func longpressed(sender: AnyObject) {
        let lpress = sender as! UILongPressGestureRecognizer
        var point = lpress.locationInView(self.view)
        
        nr1 = UIDynamicItemBehavior(items: [self.btn1])
        nr1.allowsRotation = false
        nr2 = UIDynamicItemBehavior(items: [self.btn2])
        nr2.allowsRotation = false
        nr3 = UIDynamicItemBehavior(items: [self.btn3])
        nr3.allowsRotation = false
        nr4 = UIDynamicItemBehavior(items: [self.btn4])
        nr4.allowsRotation = false
        
        var point1 = CGPointMake(point.x-126, point.y-70)
        var point2 = CGPointMake(point.x-66, point.y-121)
        var point3 = CGPointMake(point.x+22, point.y-121)
        var point4 = CGPointMake(point.x+87, point.y-70)
        
        btn1.frame = CGRectMake(point.x, point.y, 48, 48)
        btn2.frame = CGRectMake(point.x, point.y, 48, 48)
        btn3.frame = CGRectMake(point.x, point.y, 48, 48)
        btn4.frame = CGRectMake(point.x, point.y, 48, 48)
        
        
        if sender.state == UIGestureRecognizerState.Began{
            UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.btn1.alpha = 1
                self.btn2.alpha = 1
                self.btn3.alpha = 1
                self.btn4.alpha = 1
            }, completion: {finished in})
           
            self.dynamicAnimator?.addBehavior(nr1)
            self.dynamicAnimator?.addBehavior(nr2)
            self.dynamicAnimator?.addBehavior(nr3)
            self.dynamicAnimator?.addBehavior(nr4)
            self.dynamicAnimator?.removeAllBehaviors()
            
            self.snap1 = UISnapBehavior(item:self.btn1 ,snapToPoint:point1)
            self.snap2 = UISnapBehavior(item:self.btn2 ,snapToPoint:point2)
            self.snap3 = UISnapBehavior(item:self.btn3 ,snapToPoint:point3)
            self.snap4 = UISnapBehavior(item:self.btn4 ,snapToPoint:point4)
            
            
            self.dynamicAnimator?.addBehavior(self.snap1)
            self.dynamicAnimator?.addBehavior(self.snap2)
            self.dynamicAnimator?.addBehavior(self.snap3)
            self.dynamicAnimator?.addBehavior(self.snap4)
        }
        else{
            UIView.animateWithDuration(0.25, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.btn1.alpha = 0
                self.btn2.alpha = 0
                self.btn3.alpha = 0
                self.btn4.alpha = 0
                }, completion: {finished in})
            
            
            self.snap1 = UISnapBehavior(item:self.btn1 ,snapToPoint:point)
            self.snap2 = UISnapBehavior(item:self.btn2 ,snapToPoint:point)
            self.snap3 = UISnapBehavior(item:self.btn3 ,snapToPoint:point)
            self.snap4 = UISnapBehavior(item:self.btn4 ,snapToPoint:point)
            
            self.dynamicAnimator?.addBehavior(nr1)
            self.dynamicAnimator?.addBehavior(nr2)
            self.dynamicAnimator?.addBehavior(nr3)
            self.dynamicAnimator?.addBehavior(nr4)
            self.dynamicAnimator?.addBehavior(self.snap1)
            self.dynamicAnimator?.addBehavior(self.snap2)
            self.dynamicAnimator?.addBehavior(self.snap3)
            self.dynamicAnimator?.addBehavior(self.snap4)
        }
        
        
        
    }
    
    
    
    
    
    

}
