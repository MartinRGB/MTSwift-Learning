//
//  TipViewController.swift
//  Intruduction Tips
//
//  Created by KingMartin on 15/9/27.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

private let cardoffset:CGFloat = 500
private let cardheight:CGFloat = 400
private let cardwidth:CGFloat = 300

class TipViewController: UIViewController {
    var tipView:TipView!
    var animator:UIDynamicAnimator!
    var attachmentBehavior:UIAttachmentBehavior!
    var snapBehavior:UISnapBehavior!
    var panBehavior: UIAttachmentBehavior!
    
    var tips = [Tip]()
    var index = 0
    
    enum TipviewPosition:Int{
        case Default
        case RotationLeft
        case RotationRight
        
        //移动对于卡片位置的改变
        func viewCenter(var center:CGPoint) ->CGPoint{
            switch self{
                //卡片左移 下移
            case.RotationLeft:
                center.y += cardoffset
                center.x -= cardoffset
                //卡片下移 右移
            case.RotationRight:
                center.y += cardoffset
                center.x += cardoffset
                
            default:
                ()
            }
            return center
        }
        
        //定制位置改变动画
        func viewTransform() -> CGAffineTransform {
            switch self {
            case .RotationLeft:
                return CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
                
            case .RotationRight:
                return CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                
            default:
                return CGAffineTransformIdentity
            }
        }

    }

    //设置页面,页码控制
    func setupTipview(tipView:TipView,index:Int){
        if index < tips.count{
            let tip = tips[index]
            tipView.tip = tip
            
            tipView.pagecontrol.numberOfPages = tips.count
            tipView.pagecontrol.currentPage = index
        }
        else{
            tipView.tip = nil
        }
    }
    
    
    //新建TipView方法，获取TipView的Xib
    func createTipview()->TipView?{
        if let view = UINib(nibName: "TipView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! TipView?{
            view.frame = CGRect(x:0, y:0, width:cardwidth, height:cardheight)
            return view
        }
        return nil
    }
    
    //实时更新，实现跟手动态
    func updateTipView(tipView:UIView,position:TipviewPosition){
        let center = CGPoint(x:CGRectGetWidth(view.bounds)/2,y:CGRectGetHeight(view.bounds)/2)
        tipView.center = position.viewCenter(center)
        tipView.transform = position.viewTransform()
    }
    
    func resetTipView(tipView:UIView,position:TipviewPosition){
        animator.removeAllBehaviors()
        
        updateTipView(tipView, position: position)
        //*****
        animator.updateItemUsingCurrentState(tipView)
        
        animator.addBehavior(attachmentBehavior)
        animator.addBehavior(snapBehavior)
    }
    
    func panTipView(pan:UIPanGestureRecognizer){
        let location = pan.locationInView(view)
        
        
        switch pan.state {
        case .Began:
            animator.removeBehavior(snapBehavior)
            panBehavior = UIAttachmentBehavior(item: tipView, attachedToAnchor: location)
            animator.addBehavior(panBehavior)
            
        case .Changed:
            panBehavior.anchorPoint = location
            
        case .Ended:
            fallthrough
        case .Cancelled:
            let center = CGPoint(x: CGRectGetWidth(view.bounds)/2, y: CGRectGetHeight(view.bounds)/2)
            let offset = location.x - center.x
            if fabs(offset) < 100 {
                //添加吸附点，移除之前所有效果
                animator.removeBehavior(panBehavior)
                animator.addBehavior(snapBehavior)
            }
            else {
                var nextIndex = self.index
                var position = TipviewPosition.RotationRight
                var nextPosition = TipviewPosition.RotationLeft
                //如果左滑 整体右移
                if offset > 0 {
                    nextIndex -= 1
                    nextPosition = .RotationLeft
                    position = .RotationRight
                }
                else {
                    nextIndex += 1
                    nextPosition = .RotationRight
                    position = .RotationLeft
                }
                //index不能小于1
                if nextIndex < 0 {
                    nextIndex = 0
                    nextPosition = .RotationRight
                }
                
                let duration = 0.4
                let center = CGPoint(x: CGRectGetWidth(view.bounds)/2, y: CGRectGetHeight(view.bounds)/2)
                
                panBehavior.anchorPoint = position.viewCenter(center)
                //完成3卡旋转后进场延迟
                dispatch_after(dispatch_time(
                    DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                        [self]
                        if nextIndex >= self.tips.count {
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        //如果没有完成，继续重设卡片，继续slide
                        else {
                            self.index = nextIndex
                            self.setupTipview(self.tipView, index: nextIndex)
                            self.resetTipView(self.tipView, position: nextPosition)
                        }
                }
            }
            
            
        default:
            ()
        }

    }
    
    func setupAnimatior(){
        animator = UIDynamicAnimator(referenceView: view)
        var center = CGPoint(x:CGRectGetWidth(view.bounds)/2,y:CGRectGetHeight(view.bounds)/2)
        
        tipView = createTipview()
        view.addSubview(tipView)
        snapBehavior = UISnapBehavior(item:tipView ,snapToPoint:center)
        
        //Y轴变化
        center.y += cardoffset
        attachmentBehavior = UIAttachmentBehavior(item: tipView, offsetFromCenter: UIOffset(horizontal: 0, vertical: cardoffset), attachedToAnchor: center)
        
        setupTipview(tipView, index: 0)
        resetTipView(tipView, position: .RotationRight)
        let pan = UIPanGestureRecognizer(target: self, action: "panTipView:")
        view.addGestureRecognizer(pan)
    }
    
    override func loadView() {
        view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimatior()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//扩展类，新建转场方法，等同于Objective-C
extension UIViewController{
    func presentTips(tips:[Tip],animated:Bool,completion:(()->Void)?){
        let controller = TipViewController()
        controller.tips = tips
        //设置转场方式
        controller.modalPresentationStyle = .OverFullScreen
        controller.modalTransitionStyle = .CrossDissolve
        presentViewController(controller, animated: animated, completion: completion)
    }
}