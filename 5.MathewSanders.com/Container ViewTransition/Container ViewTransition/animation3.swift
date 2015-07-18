//
//  twoViewController.swift
//  Container ViewTransition
//
//  Created by Martin on 15/7/18.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class animation3: UIViewController {

    @IBOutlet var topskate: UIImageView!
    
    
    let skateboard = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...5 {
            
            // create a square
            let square = UIImageView()
            square.frame = CGRect(x: 55, y: 300, width: 48, height: 12)
            square.image = UIImage(named:"Skateboard.png")
            self.view.addSubview(square)
            
            // randomly create a value between 0.0 and 150.0
            let randomYOffset = CGFloat( arc4random_uniform(200))
            
            // for every y-value on the bezier curve
            // add our random y offset so that each individual animation
            // will appear at a different y-position
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 16,y: 239 + randomYOffset))
            path.addCurveToPoint(CGPoint(x: 301, y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            anim.timeOffset = Double(arc4random_uniform(290))

            
            // add the animation 
            square.layer.addAnimation(anim, forKey: "animate position along path")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnpressed(sender: AnyObject) {
        
        let duration = 2.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModeLinear
        let fullRotation = CGFloat(M_PI * 2)
        //keyframe1
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: {self.topskate.transform = CGAffineTransformMakeRotation(1/3 * fullRotation)})
            //keyframe2
            UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
                self.topskate.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
            })
            //keyframe3
            UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
                self.topskate.transform = CGAffineTransformMakeRotation(3/3 * fullRotation)
            })
            
            
        
            }, completion: {finished in})
        
    }
   

}
