//
//  Transition3MenuTransitionManager.swift
//  Container ViewTransition
//
//  Created by Martin on 15/7/25.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class MenuTransitionManager: UIPercentDrivenInteractiveTransition,
          UIViewControllerAnimatedTransitioning,
          UIViewControllerTransitioningDelegate,
          UIViewControllerInteractiveTransitioning {
    //一开始不展示menu页
    //用来判定menu是否出现
    private var presenting = false
    //用来判定是否有交互事件
    private var interactive = false
    //建立边缘滑动入场手势识别器
    private var enterPanGesture:UIScreenEdgePanGestureRecognizer!
    
    
    //sourceView底部层
    var sourceViewController:UIViewController!{
        didSet{
            self.enterPanGesture = UIScreenEdgePanGestureRecognizer()
            self.enterPanGesture.addTarget(self, action: "handleOnstagePan")
            self.enterPanGesture.edges=UIRectEdge.Left
            self.sourceViewController.view.addGestureRecognizer(self.enterPanGesture)
            
        }
    }
    
    //建立边缘滑动退场手势识别器
    private var exitPanGesture: UIPanGestureRecognizer!
    
    //menuview菜单层
    var menuViewController: UIViewController! {
        didSet {
            self.exitPanGesture = UIPanGestureRecognizer()
            self.exitPanGesture.addTarget(self, action:"handleOffstagePan:")
            self.menuViewController.view.addGestureRecognizer(self.exitPanGesture)
        }
    }
    
    
    //手势入场
    func handleOnstagePan(pan:UIPanGestureRecognizer){
        //pan移动的距离
        let translation = pan.translationInView(pan.view!)
        //给出一个比例公式
        let d = translation.x/CGRectGetWidth(pan.view!.bounds) * 0.5
        //根据状态改变定制结果
        switch(pan.state){
        case UIGestureRecognizerState.Began:
            self.interactive = true
            self.sourceViewController.performSegueWithIdentifier("presentMenu", sender: self)
                break
        case UIGestureRecognizerState.Changed:
            //上传进度
            self.updateInteractiveTransition(d)
            break
        default:
            self.interactive = false
            
            //判定回归点
            if(d > 0.2){
                // threshold crossed: finish
                self.finishInteractiveTransition()
            }
            else {
                // threshold not met: cancel
                self.cancelInteractiveTransition()
            }
            
        }
        
    }
    
    //手势退场
    func handleOffstagePan(pan: UIPanGestureRecognizer){
        
        let translation = pan.translationInView(pan.view!)
        let d =  translation.x / CGRectGetWidth(pan.view!.bounds) * -0.5
        
        switch (pan.state) {
            
        case UIGestureRecognizerState.Began:
            self.interactive = true
            self.menuViewController.performSegueWithIdentifier("dismissMenu", sender: self)
            break
            
        case UIGestureRecognizerState.Changed:
            self.updateInteractiveTransition(d)
            break
            
        default: // .Ended, .Cancelled, .Failed ...
            self.interactive = false
            
            //判定回归点
            if(d > 0.1){
                self.finishInteractiveTransition()
            }
            else {
                self.cancelInteractiveTransition()
            }
        }
    }
    
    /*
    We’re going to add an observer to our sourceViewController property. With the following syntax we can create a mini block of code that will get executed anytime that variable is updated.
    
    We’ll use this so that anytime the sourceViewController is updated we initialize our gesture recognizer and add it to the main view of the property.*/
    
    
    
    //动画设置
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        //动画容器
        let container = transitionContext.containerView()
        
        //创建元祖，涵盖2个ViewController，并设置两个vc之间引发转场的key
        let screens :(from:UIViewController,to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!,transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let menuViewController = !self.presenting ?screens.from as! MenuViewController :screens.to as! MenuViewController
        let topViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let topView = topViewController.view
        
        //如果即将展示，那么menu页初始alpha为0,这里拓展，可以制作开关动画/可以做动画属性初始化
        if (self.presenting){
            topView.transform = CGAffineTransformMakeScale(1, 1)
            
            
            self.offStageMenuController(menuViewController)
        }
        
        //加入容器
        
        container.addSubview(menuView)
        container.addSubview(topView)
        
        
        
        //设置时间
        let duration = self.transitionDuration(transitionContext)
        
        //设置动画
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: nil, animations: {
            
            // either fade in or fade out
            if (self.presenting){
                self.onStageMenuController(menuViewController)
                topView.transform = self.offStage(290)
            }
            else{
                
                topView.transform = CGAffineTransformIdentity
                self.offStageMenuController(menuViewController)
            }
            
            }, completion: { finished in
                
                
                if(transitionContext.transitionWasCancelled()){
                    
                    transitionContext.completeTransition(false)
                    // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                    UIApplication.sharedApplication().keyWindow!.addSubview(screens.from.view)
                    
                }
                else {
                    // 告知转场上下文完成动画，不加则无法反过来
                    transitionContext.completeTransition(true)
                    // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                    UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                    
                }
                
        })
        
    }
    //**** Only X,将CGFloat赋值给位移变量中得amount
    func offStage(amount:CGFloat)->CGAffineTransform{
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    func offStageMenuController(menuViewController:MenuViewController){
        
        menuViewController.view.alpha = 0
        
        let offstageOffset  :CGFloat = -200
        
        menuViewController.l1.transform = self.offStage(offstageOffset)
        menuViewController.l2.transform = self.offStage(offstageOffset)
        menuViewController.l3.transform = self.offStage(offstageOffset)
        menuViewController.l4.transform = self.offStage(offstageOffset)
        menuViewController.l5.transform = self.offStage(offstageOffset)
        menuViewController.l6.transform = self.offStage(offstageOffset)
    }
    
    func onStageMenuController(menuViewController: MenuViewController){
        
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
        //手势展现menu
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
            // if our interactive flag is true, return the transition manager object
            // otherwise return nil
            return self.interactive ? self : nil
        }
        //手势取消menu
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) ->UIViewControllerInteractiveTransitioning? {
            return self.interactive ? self : nil
        }
    
   
}
