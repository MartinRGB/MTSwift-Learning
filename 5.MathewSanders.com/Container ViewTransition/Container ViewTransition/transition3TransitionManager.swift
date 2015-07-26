//
//  transition3TransitionManager.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/26.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

//协议
class transition3TransitionManager: UIPercentDrivenInteractiveTransition,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
    
    private var interactive = false
    private var presenting = false
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //动画容器
        let container = transitionContext.containerView()
        
        //创建元祖，涵盖2个ViewController，并设置两个vc之间引发转场的key
        let screens :(from:UIViewController,to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!,transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let mvController = !self.presenting ? screens.from as! slidemenuViewController : screens.to as! slidemenuViewController
        let tvController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = mvController.view
        let topView = tvController.view
        
        if (self.presenting){
            menuView.alpha = 0
            
            mvController.icon1.transform = self.offStage(1100)
            mvController.icon2.transform = self.offStage(1000)
            mvController.icon3.transform = self.offStage(900)
            mvController.icon4.transform = self.offStage(800)
            mvController.icon5.transform = self.offStage(700)
            mvController.icon6.transform = self.offStage(600)
        }
        
        //加入容器
        container.addSubview(topView)
        container.addSubview(menuView)
        
        
        //设置时间
        let duration = self.transitionDuration(transitionContext)
        
        //设置动画
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: nil, animations: {
            
            // either fade in or fade out
            if (self.presenting){
                
            }
            else{
                self.offStageMenuController(slidemenuViewController)
                
            }
            
            }, completion: { finished in
                
                // 告知转场上下文完成动画，不加则无法反过来
                transitionContext.completeTransition(true)
                
                // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                
        })
        
    }
    
    
    //退场
    func offStageMenuController(menuViewController:Transitionmenuonebottom3){
        
        menuViewController.view.alpha = 0
        
        
        
        mvController.icon1.transform = self.offStage(-topRowOffset)
        mvController.icon2.transform = self.offStage(topRowOffset)
        mvController.icon3.transform = self.offStage(-middleRowOffset)
        mvController.icon4.transform = self.offStage(middleRowOffset)
        mvController.icon5.transform = self.offStage(-bottomRowOffset)
        mvController.icon6.transform = self.offStage(bottomRowOffset)
    }
    
    
    //入场
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
    
    
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
    //开启
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
     
        //如果interactive flag为真，那么，返回transition manager对象
        return self.interactive ? self : nil
    }
    
    //取消
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
    //**** Only X,将CGFloat赋值给位移变量中得amount
    func offStage(amount:CGFloat)->CGAffineTransform{
        return CGAffineTransformMakeTranslation(0, amount)
    }
    
   
}
