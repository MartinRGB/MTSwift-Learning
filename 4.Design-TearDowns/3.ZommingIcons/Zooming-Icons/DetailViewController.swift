//
//  DetailViewController.swift
//  Zooming-Icons
//
//  Created by KingMartin on 15/9/23.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class DetailViewController:UIViewController,ZoomingIconViewController{
    
    @IBOutlet weak var coloredView:UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    //利用constraint做动画
    
    
    @IBOutlet weak var backtop: NSLayoutConstraint!
    @IBOutlet weak var summar: NSLayoutConstraint!
    var item: SocialItem?
    
    
    //两个状态对于constraint的影响 ---Method to adjust parameter
    // layoutIfNeeded() (this tells Auto Layout to recompute the frames of the subviews).
    
    func setupState(initial: Bool) {
        if initial {
            backtop.constant = -64
            summar.constant = -300
        }
        else {
            backtop.constant = 0
            summar.constant = 40
        }
        self.view.layoutIfNeeded()
        print("\(summar.constant)")
    }
    
    func zoomingIconTransition(transition: ZoomingIconTransition, willAnimateTransitionWithOperation operation: UINavigationControllerOperation, isForegroundViewController isForeground: Bool){
        setupState(operation == .Push)
        
        UIView.animateWithDuration(0.6, delay: operation == .Push ? 0.2 : 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            [self]
            self.setupState(operation == .Pop)
            }) { (finished) -> Void in
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取正确的子页面信息
        if let item = item {
            coloredView.backgroundColor = item.color
            imageView.image = item.image
            
            titleLabel.text = item.name
            summaryLabel.text = item.summary
        }
        else {
            coloredView.backgroundColor = UIColor.grayColor()
            imageView.image = nil
            
            titleLabel.text = nil
            summaryLabel.text = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    
    //按钮返回
    @IBAction func handleback(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func zoomingIconColoredViewForTransition(transition: ZoomingIconTransition) -> UIView! {
        return coloredView
    }
    
    func zoomingIconImageViewForTransition(transition: ZoomingIconTransition) -> UIImageView! {
        return imageView
    }
    
    
    
    
    
    
}
