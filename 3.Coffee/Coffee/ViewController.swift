//
//  ViewController.swift
//  Coffee
//
//  Created by Martin on 15/7/14.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var gif: UIImageView!
    @IBOutlet var blurview: UIVisualEffectView!
    @IBOutlet var blackmask: UIImageView!
    @IBOutlet var introtext: UIImageView!
    @IBOutlet var startbutton: UIButton!
    
    
    @IBOutlet var mainview: UIView!
    
    var counter = 0
    var timer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        play()
        
        
        
            self.introtext.frame.origin.y = 542
            self.introtext.transform = CGAffineTransformMakeScale(2, 2)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.blurview.alpha = 0.5
            self.blackmask.alpha = 1
            self.introtext.alpha = 1
            
            }, completion: { finished in
        })
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
            self.introtext.frame.origin.y = 72
            self.introtext.transform = CGAffineTransformMakeScale(1, 1)
            self.startbutton.frame.origin.y -= 518
            }, completion: { finished in
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func play(){
        timer = NSTimer.scheduledTimerWithTimeInterval(0.03, target: self, selector: ("gifsequence"), userInfo: nil, repeats: true)
    }
    
    func gifsequence(){
        
        counter++
        if counter == 101{
            counter = 0
        }
        
        gif.image = UIImage(named:"Coffee\(counter)")
        println(counter)
    }
    
    
    @IBAction func getstartbtn(sender: AnyObject) {
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: {
            self.mainview.alpha = 0
            self.mainview.transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.introtext.frame.origin.y = 72
            }, completion: { finished in
                self.performSegueWithIdentifier("introtomain", sender: self)
        })
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "introtomain" {
            let controller = segue.destinationViewController as! NavigationViewController
        }
    }

}

