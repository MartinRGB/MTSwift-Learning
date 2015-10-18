//
//  TransitionManager.swift
//  Rooms
//
//  Created by KingMartin on 15/9/26.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class TransitionManager: NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate{
//状态制造
    enum State{
        case None
        case Presenting
        case Dismissing
    }
    
    var state = State.None
    var presentingController: UIViewController!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(transitionContext)
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        
        var bgVC = fromVC
        var fgVC = toVC
        
        if(state == .Dismissing){
            bgVC = toVC
            fgVC = fromVC
        }
        
        print("\(state)")
        // get detail view from view controllers
        
        let foregroundDetailViewMaybe = (fgVC as? TransitionManagerViewController)?.transitionMangagerDetailViewForTransition(self)
        let backgroundDetailViewMaybe = (bgVC as? TransitionManagerViewController)?.transitionMangagerDetailViewForTransition(self)
        
       
        assert(foregroundDetailViewMaybe != nil, "Cannot find detail view in foreground view controller")
        assert(backgroundDetailViewMaybe != nil, "Cannot find detail view in background view controller")
        
        let backgroundDetailView = backgroundDetailViewMaybe!
        let foregroundDetailView = foregroundDetailViewMaybe!
        
        
        // add views to container
        containerView?.addSubview(bgVC!.view)
        
        let wrapperView = UIView(frame: fgVC!.view.frame)
        wrapperView.layer.shadowRadius = 5
        wrapperView.layer.shadowOpacity = 0.3
        wrapperView.layer.shadowOffset = CGSizeZero
        wrapperView.addSubview(fgVC!.view)
        fgVC!.view.clipsToBounds = true
        
        containerView?.addSubview(wrapperView)
        // perform animation
        (fgVC as? TransitionManagerViewController)?.transitionManagerWillANimateTransition?(self, presenting: state == .Presenting, isFG: true)
        
        backgroundDetailView.hidden = true
        
        let backgroundFrame = containerView!.convertRect(backgroundDetailView.frame, fromView: backgroundDetailView.superview)
        let screenBounds = UIScreen.mainScreen().bounds
        let scale = backgroundFrame.width / screenBounds.width
        
        if state == .Presenting {
            wrapperView.transform = CGAffineTransformMakeScale(scale, scale)
            foregroundDetailView.transitionProgress = 1
        }
        else {
            wrapperView.transform = CGAffineTransformIdentity
        }
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            [self]
            if self.state == .Presenting {
                wrapperView.transform = CGAffineTransformIdentity
                foregroundDetailView.transitionProgress = 0
            }
            else {
                wrapperView.transform = CGAffineTransformMakeScale(scale, scale)
                foregroundDetailView.transitionProgress = 1
            }
            
            }) { (finished) -> Void in
                backgroundDetailView.hidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
    }
    

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        state = .Presenting
        return self
    
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        state = .Dismissing
        return self
    }
    
    
}

@objc
protocol TransitionManagerViewController {
    func transitionMangagerDetailViewForTransition(transition:TransitionManager)->DetailView!
    
    optional func transitionManagerWillANimateTransition(transition:TransitionManager, presenting: Bool, isFG: Bool)
    
}
