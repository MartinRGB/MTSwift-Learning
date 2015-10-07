//
//  TransitionManager.swift
//  6.Expanding-Cells
//
//  Created by KingMartin on 15/10/1.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

private let transitionduration:NSTimeInterval = 0.6

class TransitionManager: NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate{
    
    //枚举转场行为
    enum TransitionStyle{
        case None
        case Presenting
        case Dismissing
    }
    var type:TransitionStyle = .None
    var presentingController :UIViewController!
    var presentedController :UIViewController!
    
    //枚举状态
    enum State{
        case Inital
        case Final
    }
    
    //SnapShotArea
    var targetSnapshot: UIView!
    var targetContainer: UIView!
    var topRegionSnapshot: UIView!
    var bottomRegionSnapshot: UIView!
    var navigationBarSnapshot: UIView!
    
    //Prepare0: 具体截图方法
    func sliceSnapshotsInbgVC(bgVC:UIViewController,targetFrame:CGRect,targetView:UIView){
        
        let view = bgVC.view
        let width = view.bounds.width
        let height = view.bounds.height
        
        //MARK:TOP AREA xyw，h一直到选中target顶部
        topRegionSnapshot = view.resizableSnapshotViewFromRect(CGRect(x:0,y:0,width:width,height:targetFrame.minY), afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        
        //MARK: BOTTOM AREA xywh注意
        bottomRegionSnapshot = view.resizableSnapshotViewFromRect(CGRect(x: 0, y: targetFrame.maxY, width: width, height: height-targetFrame.maxY), afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        
        //MARK:TargetView截图(转场完成后的视图)
        targetSnapshot = targetView.snapshotViewAfterScreenUpdates(false)
        targetContainer = UIView(frame: targetFrame)
        targetContainer.backgroundColor = UIColor.whiteColor()
        targetContainer.clipsToBounds = true
        targetContainer.addSubview(targetSnapshot)
        
        //MARK:处理Navigation Bar
        
        /*1.generate UIImages and create UIImageViews to host them. we can work easily using the UIKit convenience methods UIGraphicsBeginImageContext() and UIGraphicsEndImageContext(). 
           
          P.SAny drawing functions will have to be called between these pairs of functions.
        
          2.Next, we use the drawViewHierarchyInRect() method on UIView to draw the view's contents into the [current] image context. Finally, we use UIGraphicsGetImageFromCurrentImageContext() to retrieve the UIImage from the image context.
        */
        
        if let navController = bgVC as? UINavigationController{
            //获取NavBar高度
            let barHeight = navController.navigationBar.frame.maxY
            
            //获取当前图像关系上下文
            UIGraphicsBeginImageContext(CGSize(width: width, height: barHeight))
            
            //Renders a snapshot of the complete view hierarchy as visible onscreen into the current context.
            view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: false)
            
            //从之前获取的上下文中提取图像
            let navigationBarImage = UIGraphicsGetImageFromCurrentImageContext()
            //中止上下文关系
            UIGraphicsEndImageContext()
            //将上下文图像加载到截图View中
            navigationBarSnapshot = UIImageView(image:navigationBarImage)
            navigationBarSnapshot.backgroundColor = navController.navigationBar.barTintColor
            navigationBarSnapshot.contentMode = .Bottom
            
            
        }
        
    }
    
    //Prepare1: 定义两种状态下Top/Bottom/Snap Area的Height & Alpha
    func configureViewToState(state:State,width:CGFloat,height:CGFloat,targetFrame:CGRect,fullFrame:CGRect,fgVC:UIView){
        switch state{
        case .Inital:
            topRegionSnapshot.frame = CGRect(x: 0, y: 0, width: width, height: targetFrame.minY)
            bottomRegionSnapshot.frame = CGRect(x: 0, y: targetFrame.maxY, width: width, height: height-targetFrame.maxY)
            targetContainer.frame = targetFrame
            targetSnapshot.alpha = 1
            fgVC.alpha = 0
            navigationBarSnapshot.sizeToFit()
            
        case .Final:
            topRegionSnapshot.frame = CGRect(x: 0, y: -targetFrame.minY, width: width, height: targetFrame.minY)
            bottomRegionSnapshot.frame = CGRect(x: 0, y: height, width: width, height: height-targetFrame.maxY)
            targetContainer.frame = fullFrame
            targetSnapshot.alpha = 0
            fgVC.alpha = 1
        }
    }
    
    
    
    //1.设置时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionduration
    }
    
    //2.动画转场
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //fg&bg&to&from
        let duration = transitionDuration(transitionContext)
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        var foregroundViewController = toViewController
        var backgroundViewController = fromViewController
        
        if type == .Dismissing {
            foregroundViewController = fromViewController
            backgroundViewController = toViewController
        }
        
        containerView?.addSubview(backgroundViewController.view)
        containerView?.addSubview(foregroundViewController.view)
        
        // get target view
        var targetViewController = backgroundViewController
        if let navController = targetViewController as? UINavigationController {
            targetViewController = navController.topViewController!
        }
        let targetViewMaybe = (targetViewController as? TransitionManagerPresentingVC)?.transitionManagerTargetViewForTransition(self)
        
        assert(targetViewMaybe != nil, "Cannot find target view in background view controller")
        
        let targetView = targetViewMaybe!
        
        // setup animation
        let targetFrame = backgroundViewController.view.convertRect(targetView.frame, fromView: targetView.superview)
        if type == .Presenting {
            
            sliceSnapshotsInbgVC(backgroundViewController, targetFrame: targetFrame, targetView: targetView)
            (foregroundViewController as? TransitionManagerPresentedVC)?.transitionManager(self, navigationBarSnapshot: navigationBarSnapshot)
        }
        else {
            navigationBarSnapshot.frame = containerView!.convertRect(navigationBarSnapshot.frame, fromView: navigationBarSnapshot.superview)
        }
        
        targetContainer.addSubview(foregroundViewController.view)
        containerView?.addSubview(targetContainer)
        containerView?.addSubview(topRegionSnapshot)
        containerView?.addSubview(bottomRegionSnapshot)
        containerView?.addSubview(navigationBarSnapshot)
        
        let width = backgroundViewController.view.bounds.width
        let height = backgroundViewController.view.bounds.height
        
        let preTransition: State = (type == .Presenting ? .Inital : .Final)
        let postTransition: State = (type == .Presenting ? .Final : .Inital)
        
        configureViewToState(preTransition, width: width, height: height, targetFrame: targetFrame, fullFrame: foregroundViewController.view.frame, fgVC: foregroundViewController.view)
        
        // perform animation
        backgroundViewController.view.hidden = true
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            [self]
            self.configureViewToState(postTransition, width: width, height: height, targetFrame: targetFrame, fullFrame: foregroundViewController.view.frame, fgVC: foregroundViewController.view)
            
            if self.type == .Presenting {
                self.navigationBarSnapshot.frame.size.height = 0
            }
            
            }, completion: {
                (finished) in
                [self]
                self.targetContainer.removeFromSuperview()
                self.topRegionSnapshot.removeFromSuperview()
                self.bottomRegionSnapshot.removeFromSuperview()
                self.navigationBarSnapshot.removeFromSuperview()
                
                containerView?.addSubview(foregroundViewController.view)
                backgroundViewController.view.hidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
    
    
    //3.Presenting
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentingController = presenting
        if let navController = presentingController as? UINavigationController{
            presentingController = navController.topViewController
        }
        
        if presentingController is TransitionManagerPresentingVC{
            type = .Presenting
            return self
        }
        
        else{
            type = .None
            return nil
        }
    }
    
    //4.Dismissing
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presentingController is TransitionManagerPresentingVC{
            type = .Dismissing
            return self
        }
        else{
            type = .None
            return nil
        }
    }
    
}


//搞清哪个呗选中了-know where happened the transition
@objc
protocol TransitionManagerPresentingVC{
    func transitionManagerTargetViewForTransition(transition:TransitionManager)-> UIView!
}

@objc
protocol TransitionManagerPresentedVC{
    func transitionManager(transition:TransitionManager,navigationBarSnapshot:UIView)
}
