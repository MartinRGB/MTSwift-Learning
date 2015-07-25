//
//  Transition2Menu3TransitionManager.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/25.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class Transition2Menu3TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    //一开始不展示menu页
    private var presenting = false
    //动画设置
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        //动画容器
        let container = transitionContext.containerView()
        
        //创建元祖，涵盖2个ViewController，并设置两个vc之间引发转场的key
        let screens :(from:UIViewController,to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!,transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let menuViewController = !self.presenting ?screens.from as! Transitionmenuonebottom3 :screens.to as! Transitionmenuonebottom3
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        //如果即将展示，那么menu页初始alpha为0,这里拓展，可以制作开关动画/可以做动画属性初始化
        if (self.presenting){
            menuView.alpha = 0
            bottomView.transform = CGAffineTransformMakeScale(1, 1)
            
            let topRowOffset:CGFloat = 300
            let middleRowOffset:CGFloat = 150
            let bottomRowOffset : CGFloat = 50
            
            menuViewController.l1.transform = self.offStage(-topRowOffset)
            menuViewController.l2.transform = self.offStage(topRowOffset)
            menuViewController.l3.transform = self.offStage(-middleRowOffset)
            menuViewController.l4.transform = self.offStage(middleRowOffset)
            menuViewController.l5.transform = self.offStage(-bottomRowOffset)
            menuViewController.l6.transform = self.offStage(bottomRowOffset)
        }
        
        //加入容器
        container.addSubview(bottomView)
        container.addSubview(menuView)
        
        //设置时间
        let duration = self.transitionDuration(transitionContext)
        
        //设置动画
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: nil, animations: {
            
            // either fade in or fade out
            if (self.presenting){
                self.onStageMenuController(menuViewController)
                
                bottomView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }
            else{
                self.offStageMenuController(menuViewController)
                bottomView.transform = CGAffineTransformIdentity
            }
            
            }, completion: { finished in
                
                // 告知转场上下文完成动画，不加则无法反过来
                transitionContext.completeTransition(true)
                
                // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                
        })
        
    }
    //**** Only X,将CGFloat赋值给位移变量中得amount
    func offStage(amount:CGFloat)->CGAffineTransform{
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    func offStageMenuController(menuViewController:Transitionmenuonebottom3){
        
        menuViewController.view.alpha = 0
        
        
        let topRowOffset:CGFloat = 300
        let middleRowOffset:CGFloat = 150
        let bottomRowOffset : CGFloat = 50
        
        menuViewController.l1.transform = self.offStage(-topRowOffset)
        menuViewController.l2.transform = self.offStage(topRowOffset)
        menuViewController.l3.transform = self.offStage(-middleRowOffset)
        menuViewController.l4.transform = self.offStage(middleRowOffset)
        menuViewController.l5.transform = self.offStage(-bottomRowOffset)
        menuViewController.l6.transform = self.offStage(bottomRowOffset)
    }
    
    func onStageMenuController(menuViewController: Transitionmenuonebottom3){
        
        //CGAffineTransformIdentity重置回位置
        menuViewController.view.alpha = 1
        
        menuViewController.l1.transform = CGAffineTransformIdentity
        
        menuViewController.l2.transform = CGAffineTransformIdentity
        
        menuViewController.l3.transform = CGAffineTransformIdentity
        
        menuViewController.l4.transform = CGAffineTransformIdentity
        
        menuViewController.l5.transform = CGAffineTransformIdentity
        
        menuViewController.l6.transform = CGAffineTransformIdentity
        
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
