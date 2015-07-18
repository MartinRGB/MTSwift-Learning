//
//  threeViewController.swift
//  Container ViewTransition
//
//  Created by Martin on 15/7/18.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class animation4: UIViewController {

    
let Doge = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create and add blue-fish.png image to screen
        Doge.image = UIImage(named: "Doge.png")
        Doge.frame = CGRect(x: 110, y: 98.5, width: 100, height: 100)
        self.view.addSubview(Doge)
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonpressed(sender: AnyObject) {
        
        
        // 设置路径
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = CGRectMake(97.5, 88.5, 125, 125)
        
        let ovalPath = UIBezierPath()
        //圆心、半径、正逆时
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)
        //CAShapelayer加载Path
        let progressLine = CAShapeLayer()
        progressLine.path = ovalPath.CGPath
        progressLine.strokeColor = UIColor.blueColor().CGColor
        progressLine.fillColor = UIColor.clearColor().CGColor
        progressLine.lineWidth = 10.0
        progressLine.lineCap = kCALineCapRound
        self.view.layer.addSublayer(progressLine)
        
        //anim part
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 1.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        //Doge Delete
        // create an array of views to animate (in this case just one)
        let viewsToAnimate = [Doge]
        
        UIView.performSystemAnimation(UISystemAnimation.Delete, onViews: [Doge], options: nil, animations: {
            
            }, completion: { finished in
                
                
        })
    }
    
    
    
    
    

}
