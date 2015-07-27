//
//  Transition2Menu2TransitionManager.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/25.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class Transition2Menu2TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    //一开始不展示menu页
   private var presenting = false
    //动画设置
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        //动画容器
        let container = transitionContext.containerView()
        
        //创建元祖，涵盖2个ViewController，并设置两个vc之间引发转场的key
        let screens :(from:UIViewController,to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!,transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let menuViewController = !self.presenting ?screens.from as! Transitionmenuonebottom2 :screens.to as! Transitionmenuonebottom2
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        //如果即将展示，那么menu页初始alpha为0,这里拓展，可以制作开关动画/可以做动画初始化
        if (self.presenting){
            menuView.alpha = 0
            bottomView.transform = CGAffineTransformMakeScale(1, 1)
            menuView.transform = CGAffineTransformMakeScale(0.9, 0.9)
        }

        //加入容器
        container.addSubview(bottomView)
        container.addSubview(menuView)
        
        //设置时间
        let duration = self.transitionDuration(transitionContext)
        
        //设置动画
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: nil, animations: {
            
            // either fade in or fade out
            menuView.alpha = self.presenting ? 1 : 0
            bottomView.transform = self.presenting ? CGAffineTransformMakeScale(0.9, 0.9): CGAffineTransformMakeScale(1, 1)
            menuView.transform = self.presenting ? CGAffineTransformMakeScale(1, 1): CGAffineTransformMakeScale(0.9, 0.9)
            
            }, completion: { finished in
                
                // 告知转场上下文完成动画，不加则无法反过来
                transitionContext.completeTransition(true)
                
                // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                
        })
        
    }
    //时间设置
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    //去 present
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    //回 dismiss
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
