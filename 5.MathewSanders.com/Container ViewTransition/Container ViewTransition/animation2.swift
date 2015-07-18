//
//  oneViewController.swift
//  Container ViewTransition
//
//  Created by Martin on 15/7/18.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class animation2: UIViewController {

    let container = UIView()
    let redSquare = UIView()
    let blueSquare = UIView()
    
    override func viewDidLoad() {
        
        //set up three view
        super.viewDidLoad()
        
        self.container.frame = CGRect(x: 60,y: 160,width: 200,height: 200)
        self.view.addSubview(container)
        
        self.redSquare.frame = CGRect(x: 0,y: 0,width: 200,height: 200)
        self.blueSquare.frame = redSquare.frame
        
        self.redSquare.backgroundColor = UIColor.redColor()
        self.blueSquare.backgroundColor = UIColor.blueColor()
        
        self.container.addSubview(self.redSquare)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonpressed(sender: AnyObject) {
        //创建一个元组，容纳正反面关系
        var views : (frontView: UIView, backView: UIView)
        //如果当前是红色正面，那么背面蓝色
        if((self.redSquare.superview) != nil){
            views = (frontView: self.redSquare, backView: self.blueSquare)
        }
        //如果当前是红色不存在，那么正面蓝色
        else {
            views = (frontView: self.blueSquare, backView: self.redSquare)
        }
        
        let transitionOptions = UIViewAnimationOptions.TransitionCurlUp
        UIView.transitionWithView(self.container, duration: 1.0, options: transitionOptions, animations: {
            views.frontView.removeFromSuperview()
            self.container.addSubview(views.backView)
            }, completion: {
                finished in
        })
        
    }

    
}
