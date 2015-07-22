//
//  TransitionManager.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/22.
//  Copyright (c) 2015年 1. All rights reserved.
//
import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    private var presenting = true
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // 容器 from to
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // 2d动画
        let π : CGFloat = 3.14159265359
        
        let offScreenRight = CGAffineTransformMakeRotation(-π/2)
        let offScreenLeft = CGAffineTransformMakeRotation(π/2)
        
        // prepare the toView for the animation
        toView.transform = self.presenting ? offScreenRight : offScreenLeft
        
        //设置锚点左上角
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        
        //升级位置信息，保证位置不变
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        //2 view加载入容器
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // 设置动画世纪
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
            
            //判断是触发还是返回
            fromView.transform = self.presenting ? offScreenLeft : offScreenRight
            toView.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                
                // 告知上下文对象动画完成
                transitionContext.completeTransition(true)
                
        })
        
    }
    
    //动画世纪
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.75
    }
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // 触发
        self.presenting = true
        return self
    }
    
    // 返回
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
}
