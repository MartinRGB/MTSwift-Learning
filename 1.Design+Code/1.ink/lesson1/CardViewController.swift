//
//  CardViewController.swift
//  lesson1
//
//  Created by 1 on 15/7/7.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit
import CoreGraphics
import QuartzCore

class CardViewController: UIViewController {
    @IBOutlet weak var ink1bg: UIImageView!

    @IBOutlet weak var card1: UIImageView!
    
    @IBOutlet weak var c1img: UIImageView!
    
    
    @IBOutlet var Imagebtn: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    
    @IBOutlet weak var c1detailtxt: UIImageView!
    
    @IBOutlet weak var Cardview: UIView!
    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravityBehaviour : UIGravityBehavior!
    var snapBehavior : UISnapBehavior!
    
    var keyvalue:CGFloat = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertBlurView(ink1bg, style: UIBlurEffectStyle.Dark)
        self.view.backgroundColor = UIColor.blackColor()
        self.Cardview.transform = CGAffineTransformMakeScale(1, 1)
        // Do any additional setup after loading the view.
        
        //set animtor控制器，让 UIDynamicAnimator可以控制
        animator = UIDynamicAnimator(referenceView: view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.Cardview.transform = CGAffineTransformMakeScale(0.6, 0.6)
        
        //for the loop
        card1.image = UIImage(named: data[number]["CardThing"]!)
        Imagebtn.setImage(UIImage(named: data[number]["CardThing"]!), forState: UIControlState.Normal)
        ink1bg.image = UIImage(named: data[number]["BG"]!)
        c1img.image = UIImage(named: data[number]["Img"]!)
        c1detailtxt.image = UIImage(named: data[number]["DetailText"]!)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.Cardview.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: { finished in
        })

        
    
    
        UIView.animateWithDuration(0.3, delay: 0.4,usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.tabBarController?.tabBar.frame.origin.y = 520
            }, completion: { finished in
        })
        
        //use simple if/else to make back transition
        
        if(keyvalue < 1){
        
        let ball = CABasicAnimation(keyPath: "position.y")
        ball.fromValue = 632
        ball.toValue = 445
        ball.duration = 0.3
        ball.fillMode = kCAFillModeBoth
        ball.removedOnCompletion = false
        ball.beginTime = CACurrentMediaTime() + 0.45
        ball.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
        b1.layer.addAnimation(ball, forKey: "position.y")
        
        let ball2 = CABasicAnimation(keyPath: "position.y")
        ball2.fromValue = 625
        ball2.toValue = 445.5
        ball2.duration = 0.3
        ball2.fillMode = kCAFillModeBoth
        ball2.removedOnCompletion = false
        ball2.beginTime = CACurrentMediaTime() + 0.4
        ball2.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
        b2.layer.addAnimation(ball2, forKey: "position.y")
        
        let ball3 = CABasicAnimation(keyPath: "position.y")
        ball3.fromValue = 625
        ball3.toValue = 445.5
        ball3.duration = 0.3
        ball3.fillMode = kCAFillModeBoth
        ball3.removedOnCompletion = false
        ball3.beginTime = CACurrentMediaTime() + 0.35
        ball3.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
        b3.layer.addAnimation(ball3, forKey: "position.y")

        
        let ball4 = CABasicAnimation(keyPath: "position.y")
        ball4.fromValue = 632
        ball4.toValue = 445
        ball4.duration = 0.3
        ball4.fillMode = kCAFillModeBoth
        ball4.removedOnCompletion = false
        ball4.beginTime = CACurrentMediaTime() + 0.3
        ball4.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
        b4.layer.addAnimation(ball4, forKey: "position.y")
     
        
        var toPoint3: CGPoint = CGPointMake(160, -120)
        var fromPoint3 : CGPoint = CGPointMake(160, 120)
        let upthing1 = CABasicAnimation(keyPath: "position")
        upthing1.fromValue = NSValue(CGPoint: fromPoint3)
        upthing1.toValue = NSValue(CGPoint: toPoint3)
        upthing1.duration = 0.3
        upthing1.fillMode = kCAFillModeBoth
        upthing1.removedOnCompletion = false
        upthing1.beginTime = CACurrentMediaTime()
        upthing1.timingFunction = CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
        c1img.layer.addAnimation(upthing1, forKey: "position")
        
        
        var toPoint4: CGPoint = CGPointMake(160, 907.5)
        var fromPoint4 : CGPoint = CGPointMake(160, 579.5)
        let downthing1 = CABasicAnimation(keyPath: "position")
        downthing1.fromValue = NSValue(CGPoint: fromPoint4)
        downthing1.toValue = NSValue(CGPoint: toPoint4)
        downthing1.duration = 0.3
        downthing1.fillMode = kCAFillModeBoth
        downthing1.removedOnCompletion = false
        downthing1.beginTime = CACurrentMediaTime()
        downthing1.timingFunction = CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
        c1detailtxt.layer.addAnimation(downthing1, forKey: "position")
        
        UIView.animateWithDuration(0.4, delay: 0.1, options: .CurveEaseOut, animations: {
            self.ink1bg.alpha = 1
            self.keyvalue = 1
            
            }, completion: { finished in
        })
        }
        
    }
    
    
    
    //Add Blur to view(Function by MengTo)
    func insertBlurView (view: UIView, style: UIBlurEffectStyle) {
        view.backgroundColor = UIColor.clearColor()
        
        var blurEffect = UIBlurEffect(style: style)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, atIndex: 0)
    }
    
    //delay function by MengTo
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func imagebutton(sender: AnyObject) {
        
        let bally = CABasicAnimation(keyPath: "position.y")
        bally.fromValue = 445
        bally.toValue = 632
        bally.duration = 0.3
        bally.fillMode = kCAFillModeBoth
        bally.removedOnCompletion = false
        bally.beginTime = CACurrentMediaTime()
        bally.timingFunction = CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
        b1.layer.addAnimation(bally, forKey: "position.y")
        
        let bally2 = CABasicAnimation(keyPath: "position.y")
        bally2.fromValue = 445.5
        bally2.toValue = 625
        bally2.duration = 0.3
        bally2.fillMode = kCAFillModeBoth
        bally2.removedOnCompletion = false
        bally2.beginTime = CACurrentMediaTime() + 0.05
        bally2.timingFunction = CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
        b2.layer.addAnimation(bally2, forKey: "position.y")
        
        let bally3 = CABasicAnimation(keyPath: "position.y")
        bally3.fromValue = 445.5
        bally3.toValue = 625
        bally3.duration = 0.3
        bally3.fillMode = kCAFillModeBoth
        bally3.removedOnCompletion = false
        bally3.beginTime = CACurrentMediaTime() + 0.1
        bally3.timingFunction = CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
        b3.layer.addAnimation(bally3, forKey: "position.y")
        
        
        let bally4 = CABasicAnimation(keyPath: "position.y")
        bally4.fromValue = 445
        bally4.toValue = 632
        bally4.duration = 0.3
        bally4.fillMode = kCAFillModeBoth
        bally4.removedOnCompletion = false
        bally4.beginTime = CACurrentMediaTime() + 0.15
        bally4.timingFunction = CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
        b4.layer.addAnimation(bally4, forKey: "position.y")
        
        UIView.animateWithDuration(0.3, delay: 0.15, options: .CurveEaseIn, animations: {
            self.tabBarController?.tabBar.frame.origin.y = 568
            }, completion: { finished in
        })
        
        var toPoint: CGPoint = CGPointMake(160, 120)
        var fromPoint : CGPoint = CGPointMake(160, -120)
        let upthing = CABasicAnimation(keyPath: "position")
        upthing.fromValue = NSValue(CGPoint: fromPoint)
        upthing.toValue = NSValue(CGPoint: toPoint)
        upthing.duration = 0.3
        upthing.fillMode = kCAFillModeBoth
        upthing.removedOnCompletion = false
        upthing.beginTime = CACurrentMediaTime() + 0.4
        upthing.timingFunction = CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
        c1img.layer.addAnimation(upthing, forKey: "position")
        
        
        var toPoint2: CGPoint = CGPointMake(160, 579.5)
        var fromPoint2 : CGPoint = CGPointMake(160, 907.5)
        let downthing = CABasicAnimation(keyPath: "position")
        downthing.fromValue = NSValue(CGPoint: fromPoint2)
        downthing.toValue = NSValue(CGPoint: toPoint2)
        downthing.duration = 0.3
        downthing.fillMode = kCAFillModeBoth
        downthing.removedOnCompletion = false
        downthing.beginTime = CACurrentMediaTime() + 0.4
        downthing.timingFunction = CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
        c1detailtxt.layer.addAnimation(downthing, forKey: "position")
        
        
        UIView.animateWithDuration(0.4, delay: 0.4, options: .CurveEaseOut, animations: {
            self.ink1bg.alpha = 0
            self.Cardview.transform = CGAffineTransformMakeScale(0.6, 0.6)
            self.keyvalue = 0
            }, completion: { finished in
                self.performSegueWithIdentifier("cardtodeatil", sender: self)
        })
        
        
    }
    
    
    //controller transition control
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "cardtodeatil" {
            let controller = segue.destinationViewController as! CardDeatilViewController
            controller.data = data
            controller.number = number
        }
    }
    
    //data to get data,number for implement loop
    var data = getData()
    var number = 0
    
    //send the pan gesture recognizer infomation
    @IBOutlet var PanRecognizer: UIPanGestureRecognizer!
    
    @IBAction func HandleGesture(sender: AnyObject) {
        //捕捉sender信号
        print(sender)
        //定义sender赋予的location位置
        let location = sender.locationInView(view)
        let cardlocation = sender.locationInView(Cardview)
        
        //3 state of gesture
        
        if sender.state == UIGestureRecognizerState.Began {
            animator.removeAllBehaviors()
            
            let centerOffset = UIOffsetMake(cardlocation.x - CGRectGetMidX(Cardview.bounds), cardlocation.y - CGRectGetMidY(Cardview.bounds));
            
            //attachedToAnchor:实例化UIAttachmentBehavior，连接dynamic item的指定点(相对于dynamic item center的点)到一个锚点。
            //总而言之，让其跟手
            attachmentBehavior = UIAttachmentBehavior(item: Cardview, offsetFromCenter: centerOffset, attachedToAnchor: location)
            //震动频率，越大越飘
            attachmentBehavior.frequency = 0
            
            animator.addBehavior(attachmentBehavior)
            
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            attachmentBehavior.anchorPoint = location
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            
            animator.removeBehavior(attachmentBehavior)
            //回归中心点
            snapBehavior = UISnapBehavior(item: Cardview, snapToPoint: CGPointMake(160, 219.5))
            animator.addBehavior(snapBehavior)
            let translation = sender.translationInView(view)
            //坠落条件
            if translation.x > 180 {
                animator.removeAllBehaviors()
                
                var gravity = UIGravityBehavior(items: [Cardview])
                gravity.gravityDirection = CGVectorMake(10, -1)
                animator.addBehavior(gravity)
                
                delay(0.3) {
                    self.refreshView()
                }
            }
            else if translation.x < -180{
                animator.removeAllBehaviors()
                
                var gravity = UIGravityBehavior(items: [Cardview])
                gravity.gravityDirection = CGVectorMake(-10, -1)
                animator.addBehavior(gravity)
                
                delay(0.3) {
                    self.refreshView()
                }
            }
        }
    }
    
    @IBAction func unlike(sender: AnyObject) {
        
        animator.removeAllBehaviors()
        var gravity = UIGravityBehavior(items: [Cardview])
        gravity.gravityDirection = CGVectorMake(-10, -1)
        animator.addBehavior(gravity)
        
        delay(0.3) {
            self.number++
            if self.number > 5 {
                self.number = 0
            }
            self.delay(0.2) {
                self.animator.removeAllBehaviors()
                var gravity = UIGravityBehavior(items: [self.Cardview])
                gravity.gravityDirection = CGVectorMake(0, 0)
                self.Cardview.center = CGPointMake(160, 219.5)
                self.snapBehavior = UISnapBehavior(item: self.Cardview, snapToPoint: CGPointMake(160, 219.5))
                self.viewDidAppear(true)
                }
            
            
        }
    }
    
    @IBAction func like(sender: AnyObject) {
        animator.removeAllBehaviors()
        var gravity = UIGravityBehavior(items: [Cardview])
        gravity.gravityDirection = CGVectorMake(10, -1)
        animator.addBehavior(gravity)
        
        delay(0.3) {
            self.number++
            if self.number > 5 {
                self.number = 0
            }
            self.delay(0.2) {
                self.animator.removeAllBehaviors()
                var gravity = UIGravityBehavior(items: [self.Cardview])
                gravity.gravityDirection = CGVectorMake(0, 0)
                self.Cardview.center = CGPointMake(160, 219.5)
                self.snapBehavior = UISnapBehavior(item: self.Cardview, snapToPoint: CGPointMake(160, 219.5))
                self.viewDidAppear(true)
            }
    }
    }
    
    func refreshView() {
        number++
        if number > 5 {
            number = 0
        }
        self.delay(0.2) {
            self.animator.removeAllBehaviors()
            var gravity = UIGravityBehavior(items: [self.Cardview])
            gravity.gravityDirection = CGVectorMake(0, 0)
            self.Cardview.center = CGPointMake(160, 219.5)
            self.attachmentBehavior.anchorPoint = CGPointMake(160, 219.5)
            self.snapBehavior = UISnapBehavior(item: self.Cardview, snapToPoint: CGPointMake(160, 219.5))
            self.viewDidAppear(true)
        }
        
        
    }
    

}
