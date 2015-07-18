//
//  ViewController.swift
//  AnimationPrototype1
//
//  Created by 1 on 15/7/18.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var UIValueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func ButtonPressed(sender: AnyObject) {
        //set slider value into loop
        let numofdoge = Int(self.UIValueSlider.value)
        
        //set 10 icon
        for loopNumber in 0...numofdoge{
        //CGFloat (arc4random_uniform())
        
        let size : CGFloat = CGFloat (arc4random_uniform(40)) + 20
        let yPosition : CGFloat = CGFloat (arc4random_uniform(200))+20
        
        /*let color = UIColor(red:CGFloat (arc4random_uniform(255))/255.0,green:CGFloat (arc4random_uniform(255))/255.0,blue:CGFloat (arc4random_uniform(255))/255.0,alpha:1.0)*/
        
        let colorcube = UIImageView()
        //0-size for out of screen
        colorcube.frame = CGRectMake(0-size, yPosition, size, size)
        colorcube.image = UIImage(named:"Doge.png")
        self.view.addSubview(colorcube)
        
        let duration : NSTimeInterval = 1.0
        let delay: NSTimeInterval = NSTimeInterval(900 + arc4random_uniform(100))/200
        let options = UIViewAnimationOptions.CurveLinear
        
        
        
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            
            /*colorcube.backgroundColor = UIColor(red:CGFloat (arc4random_uniform(255))/255.0,green:CGFloat (arc4random_uniform(255))/255.0,blue:CGFloat (arc4random_uniform(255))/255.0,alpha:1.0)*/
            colorcube.frame = CGRectMake(320, yPosition, size, size)
            
            }, completion: { animationFinished in
                colorcube.removeFromSuperview()
                
        })
            
        }
      
        
        

    }

}

