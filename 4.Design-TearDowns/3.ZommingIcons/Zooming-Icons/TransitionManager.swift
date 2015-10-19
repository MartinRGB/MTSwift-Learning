//
//  TransitionManager.swift
//  Zooming-Icons
//
//  Created by KingMartin on 15/9/23.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

private let kZoomingIconTransitionDuration: NSTimeInterval = 0.6
private let kZoomingIconTransitionZoomedScale: CGFloat = 15
private let kZoomingIconTransitionBackgroundScale: CGFloat = 0.80

class ZoomingIconTransition: NSObject, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning {
    //we need nor it's pop or push
    var operation: UINavigationControllerOperation = .None
    
    enum TransitionState {
        case Initial
        case Final
    }
    
    typealias ZoomingViews = (coloredView: UIView, imageView: UIView)
    
    func configureViewsForState(state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews) {
        switch state {
            //初始状态
        case .Initial:
            //BGVC初始scale不变,alpha=1
            backgroundViewController.view.transform = CGAffineTransformIdentity
            backgroundViewController.view.alpha = 1
            //颜色层初始scale不变
            snapshotViews.coloredView.transform = CGAffineTransformIdentity
            snapshotViews.coloredView.frame = containerView.convertRect(viewsInBackground.coloredView.frame, fromView: viewsInBackground.coloredView.superview)
            snapshotViews.imageView.frame = containerView.convertRect(viewsInBackground.imageView.frame, fromView: viewsInBackground.imageView.superview)
            
        case .Final:
            backgroundViewController.view.transform = CGAffineTransformMakeScale(kZoomingIconTransitionBackgroundScale, kZoomingIconTransitionBackgroundScale)
            backgroundViewController.view.alpha = 0
            //扩大
            snapshotViews.coloredView.transform = CGAffineTransformMakeScale(kZoomingIconTransitionZoomedScale, kZoomingIconTransitionZoomedScale)
            //从之前的位置，移动到中心
            snapshotViews.coloredView.center = containerView.convertPoint(viewsInForeground.imageView.center, fromView: viewsInForeground.imageView.superview)
            //从之前的位置移动到当前frame的位置
            snapshotViews.imageView.frame = containerView.convertRect(viewsInForeground.imageView.frame, fromView: viewsInForeground.imageView.superview)
        }
    }
    //转场时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return kZoomingIconTransitionDuration
    }
    //动画转场
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(transitionContext)
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        //确定那个VC应在前
        //初始
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        //如果POP转场
        if operation == .Pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        // get the image view in the background and foreground view controllers
        //只要bgVC和fgVC在TransitionMVC中，那么获取图像
        let backgroundImageViewMaybe = (backgroundViewController as? ZoomingIconViewController)?.zoomingIconImageViewForTransition(self)
        let foregroundImageViewMaybe = (foregroundViewController as? ZoomingIconViewController)?.zoomingIconImageViewForTransition(self)
        
        assert(backgroundImageViewMaybe != nil, "Cannot find image view in background view controller")
        assert(foregroundImageViewMaybe != nil, "Cannot find image view in foreground view controller")
        //同上，获取颜色
        let backgroundImageView = backgroundImageViewMaybe!
        let foregroundImageView = foregroundImageViewMaybe!
        
        // get the colored view in the background and foreground view controllers
        
        let backgroundColoredViewMaybe = (backgroundViewController as? ZoomingIconViewController)?.zoomingIconColoredViewForTransition(self)
        let foregroundColoredViewMaybe = (foregroundViewController as? ZoomingIconViewController)?.zoomingIconColoredViewForTransition(self)
        
        assert(backgroundColoredViewMaybe != nil, "Cannot find colored view in background view controller")
        assert(foregroundColoredViewMaybe != nil, "Cannot find colored view in foreground view controller")
        
        let backgroundColoredView = backgroundColoredViewMaybe!
        let foregroundColoredView = foregroundColoredViewMaybe!
        
        // create view snapshots
        // view controller need to be in view hierarchy for snapshotting
        containerView?.addSubview(backgroundViewController.view)
        let snapshotOfColoredView = backgroundColoredView.snapshotViewAfterScreenUpdates(false)
        
        let snapshotOfImageView = UIImageView(image: backgroundImageView.image)
        snapshotOfImageView.contentMode = .ScaleAspectFit
        
        // setup animation
        //前景背景全部隐藏
        backgroundColoredView.hidden = true
        foregroundColoredView.hidden = true
        
        backgroundImageView.hidden = true
        foregroundImageView.hidden = true
        //截取的动起来
        containerView?.backgroundColor = UIColor.whiteColor()
        containerView?.addSubview(backgroundViewController.view)
        containerView?.addSubview(snapshotOfColoredView)
        containerView?.addSubview(foregroundViewController.view)
        containerView?.addSubview(snapshotOfImageView)
        
        let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.backgroundColor = UIColor.clearColor()
        //状态切换
        var preTransitionState = TransitionState.Initial
        var postTransitionState = TransitionState.Final
        
        if operation == .Pop {
            preTransitionState = TransitionState.Final
            postTransitionState = TransitionState.Initial
        }
        
        configureViewsForState(preTransitionState, containerView: containerView!, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView, snapshotOfImageView))
        
        // perform animation
        (backgroundViewController as? ZoomingIconViewController)?.zoomingIconTransition?(self, willAnimateTransitionWithOperation: operation, isForegroundViewController: false)
        (foregroundViewController as? ZoomingIconViewController)?.zoomingIconTransition?(self, willAnimateTransitionWithOperation: operation, isForegroundViewController: true)
        
        // need to layout now if we want the correct parameters for frame
        //利用layout动画将其移动到正确位置
        foregroundViewController.view.layoutIfNeeded()
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            [self]
            self.configureViewsForState(postTransitionState, containerView: containerView!, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView, snapshotOfImageView))
            
            }, completion: {
                (finished) in
                //动画完成后，去掉截图view,显示前景&背景
                backgroundViewController.view.transform = CGAffineTransformIdentity
                
                snapshotOfColoredView.removeFromSuperview()
                snapshotOfImageView.removeFromSuperview()
                
                backgroundColoredView.hidden = false
                foregroundColoredView.hidden = false
                
                backgroundImageView.hidden = false
                foregroundImageView.hidden = false
                
                foregroundViewController.view.backgroundColor = foregroundViewBackgroundColor
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
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
        })
    }
    //确认delegate
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // protocol needs to be @objc for conformance testing
        if fromVC is ZoomingIconViewController &&
            toVC is ZoomingIconViewController {
                self.operation = operation
                return self
        }
        else {
            return nil
        }
    }
}

@objc
protocol ZoomingIconViewController {
    func zoomingIconColoredViewForTransition(transition: ZoomingIconTransition) -> UIView!
    func zoomingIconImageViewForTransition(transition: ZoomingIconTransition) -> UIImageView!
    
    optional
    func zoomingIconTransition(transition: ZoomingIconTransition, willAnimateTransitionWithOperation operation: UINavigationControllerOperation, isForegroundViewController isForeground: Bool)
}

