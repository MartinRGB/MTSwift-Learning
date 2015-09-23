//
//  TransitionManager.swift
//  Zooming-Icons
//
//  Created by KingMartin on 15/9/23.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

private let TransitionDuration:NSTimeInterval = 0.6
private let mtZoomingIconTransitionZoomedScale: CGFloat = 15
private let mtZoomingIconTransitionBackgroundScale: CGFloat = 0.80



class TransitionManager:NSObject,UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate{
    //we need nor it's pop or push
    var operation: UINavigationControllerOperation = .None
    
    enum TransitionState {
        case Initial
        case Final
    }
    //define a new type, which is essentially a tuple of views, ZoomingViews:
    typealias ZoomingViews = (coloredView: UIView, imageView: UIView)
    
    
    func configureViewsForState(state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews) {
        switch state {
        //初始状态
        //The convertRect(fromView) method allows us to convert CGRects between coordinate systems of different UIViews.
        case .Initial:
            //BGVC初始scale不变,alpha=1
            backgroundViewController.view.transform = CGAffineTransformIdentity
            backgroundViewController.view.alpha = 1
            //颜色层初始scale不变
            snapshotViews.coloredView.transform = CGAffineTransformIdentity
            snapshotViews.coloredView.frame = containerView.convertRect(viewsInBackground.coloredView.frame, fromView: viewsInBackground.coloredView.superview)
            snapshotViews.imageView.frame = containerView.convertRect(viewsInBackground.imageView.frame, fromView: viewsInBackground.imageView.superview)
            
        case .Final:
            backgroundViewController.view.transform = CGAffineTransformMakeScale(mtZoomingIconTransitionBackgroundScale, mtZoomingIconTransitionBackgroundScale)
            backgroundViewController.view.alpha = 0
            //扩大
            snapshotViews.coloredView.transform = CGAffineTransformMakeScale(mtZoomingIconTransitionZoomedScale, mtZoomingIconTransitionZoomedScale)
            //从之前的位置，移动到中心
            snapshotViews.coloredView.center = containerView.convertPoint(viewsInForeground.imageView.center, fromView: viewsInForeground.imageView.superview)
            //从之前的位置移动到当前frame的位置
            snapshotViews.imageView.frame = containerView.convertRect(viewsInForeground.imageView.frame, fromView: viewsInForeground.imageView.superview)
    
        }
    }
    
    
    
    //转场时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return TransitionDuration
    
    }
    
    //动画转场
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(transitionContext)
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        
        //确定那个VC应在前
        //初始
        var bgVC = fromVC
        var fgVC = toVC
        //如果POP转场
        if operation == .Pop{
            bgVC = toVC
            fgVC = fromVC
        }
        
        //只要bgVC和fgVC在TransitionMVC中，那么获取图像
        let backgroundImageViewMaybe = (bgVC as? TransitionManagerViewController)?.zoomingIconImageViewForTransition(self)
        let foregroundImageViewMaybe = (fgVC as? TransitionManagerViewController)?.zoomingIconImageViewForTransition(self)
        
        //Using asset() gives us a crash if the specified condition is not true, making debugging easier.
        assert(backgroundImageViewMaybe != nil, "Cannot find image view in background view controller")
        assert(foregroundImageViewMaybe != nil, "Cannot find image view in foreground view controller")
        
        //同上，获取颜色
        let backgroundImageView = backgroundImageViewMaybe!
        let foregroundImageView = foregroundImageViewMaybe!
        
        let backgroundColoredViewMaybe = (bgVC as? TransitionManagerViewController)?.zoomingIconColoredViewForTransition(self)
        let foregroundColoredViewMaybe = (fgVC as? TransitionManagerViewController)?.zoomingIconColoredViewForTransition(self)
        
        assert(backgroundColoredViewMaybe != nil, "Cannot find colored view in background view controller")
        assert(foregroundColoredViewMaybe != nil, "Cannot find colored view in foreground view controller")
        
        //We can use the snapshotViewAfterScreenUpdates() method on UIView for cloning a view for animations. The view has to be in the view hierarchy for this to work so that's why we added the background view controller's view to the container view first.
        let backgroundColoredView = backgroundColoredViewMaybe!
        let foregroundColoredView = foregroundColoredViewMaybe!

        containerView!.addSubview(bgVC.view)
        let snapshotOfColoredView = backgroundColoredView.snapshotViewAfterScreenUpdates(false)
        
        let snapshotOfImageView = UIImageView(image: backgroundImageView.image)
        snapshotOfImageView.contentMode = .ScaleAspectFit
        
        //perform animation
        (bgVC as? TransitionManagerViewController)?.zoomingIconTransition?(self, willAnimateTransitionWithOperation: operation, isForegroundViewController: false)
        (fgVC as? TransitionManagerViewController)?.zoomingIconTransition?(self, willAnimateTransitionWithOperation: operation, isForegroundViewController: true)
        
        //利用layout动画将其移动到正确位置
        fgVC.view.layoutIfNeeded()
        
        
        //setup animation
        //前景背景全部隐藏
        backgroundColoredView.hidden = true
        foregroundColoredView.hidden = true
        backgroundImageView.hidden = true
        foregroundImageView.hidden = true
        //截取的动起来
        containerView!.backgroundColor = UIColor.whiteColor()
        containerView!.addSubview(snapshotOfColoredView)
        containerView!.addSubview(snapshotOfImageView)
        
        let foregroundViewBackgroundColor = fgVC.view.backgroundColor
        fgVC.view.backgroundColor = UIColor.clearColor()
        //状态切换
        var preTransitionState = TransitionState.Initial
        var postTransitionState = TransitionState.Final
        
        if operation == .Pop {
            preTransitionState = TransitionState.Final
            postTransitionState = TransitionState.Initial
        }
        
        configureViewsForState(preTransitionState, containerView: containerView!, backgroundViewController: bgVC, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView, snapshotOfImageView))
        
    
        
        // need to layout now if we want the correct parameters for frame
        
        
        
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            [self]
            self.configureViewsForState(postTransitionState, containerView: containerView!, backgroundViewController: bgVC, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView, snapshotOfImageView))
            
            }, completion: {
                (finished) in
                //动画完成后，去掉截图view,显示前景&背景
                bgVC.view.transform = CGAffineTransformIdentity
                
                snapshotOfColoredView.removeFromSuperview()
                snapshotOfImageView.removeFromSuperview()
                
                backgroundColoredView.hidden = false
                foregroundColoredView.hidden = false
                
                backgroundImageView.hidden = false
                foregroundImageView.hidden = false
                
                fgVC.view.backgroundColor = foregroundViewBackgroundColor
                //截图动画完成，加入吧
                containerView!.addSubview(toVC.view)
                
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
        
        //old stuff 直接用前一个VC动画+后一个VC动画衔接，新方法会截图，自动根据两个VC情况变化
        /*
        containerView?.addSubview(fromVC.view)
        containerView?.addSubview(toVC.view)
        toVC.view.alpha = 0
    
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            
            [self]
            toVC.view.alpha = 1

            }, completion: {(finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        
        })
        */
    
    }
    //确认delegate
    func navigationController(navigationController:UINavigationController,animationControllerForOperation operation:UINavigationControllerOperation,fromViewController fromVC:UIViewController,toViewController toVC:UIViewController)-> UIViewControllerAnimatedTransitioning?{
        
        if fromVC is TransitionManagerViewController && toVC is TransitionManagerViewController{
            self.operation = operation
            return self
        }
        //when bug use custom transition
        else{
            return nil
        }

    }
    
    
    
}

@objc
protocol TransitionManagerViewController {
    func zoomingIconColoredViewForTransition(transition: TransitionManager) -> UIView!
    func zoomingIconImageViewForTransition(transition: TransitionManager) -> UIImageView!
    
    optional
    func zoomingIconTransition(transition: TransitionManager, willAnimateTransitionWithOperation operation: UINavigationControllerOperation, isForegroundViewController isForeground: Bool)
    
}