//
//  ViewController.swift
//  Drawer
//
//  Created by KingMartin on 15/9/22.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

//init

//1.line part
private let mtControlPointRatio: CGFloat = 0.6
private let mtControlPointPulledDistance:CGFloat = 80
private let mtControlPointRoundedDistance : CGFloat = 120

//2.rounded Part
private let mtExtenedEdgesOffset:CGFloat = 100
private let mtCaptureDistance:CGFloat = 80
private let mtThresholdRatio:CGFloat = 0.6
private let mtDrawerWidth:CGFloat = 260


class ViewController: UIViewController {
    
    //3.枚举状态机
    enum State{
        case Collapsed
        case Expanded
    }
    //4.覆盖层
    let overlayview:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0,alpha:0.5)
        return view
        }()
    
    //5.抽屉层
    let drawerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.9118,green:0.9163,blue:0.9532,alpha:1.0)
        return view
        }()
    
    //6.Shape蒙板
    let shapeLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
        }()
    
    //7.track or not，跟踪状态
    var tracking: Bool = false
    //8.初始状态为关闭
    var state: State = .Collapsed
    
    // I.MARK - Method 1 pull path
    func createPulledPath(width:CGFloat,point:CGPoint) -> UIBezierPath{
        let height = view.bounds.height
        let offset = width + point.x
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: -mtExtenedEdgesOffset, y: -mtExtenedEdgesOffset))
        path.addLineToPoint(CGPoint(x: width, y: -mtExtenedEdgesOffset))
        
        // add curve
        path.addCurveToPoint(CGPoint(x: offset, y: point.y),
            controlPoint1: CGPoint(x: width, y: point.y * mtControlPointRatio),
            controlPoint2: CGPoint(x: offset, y: point.y - mtControlPointPulledDistance))
        
        path.addCurveToPoint(CGPoint(x: width, y: height + mtExtenedEdgesOffset),
            controlPoint1: CGPoint(x: offset, y: point.y + mtControlPointPulledDistance),
            controlPoint2: CGPoint(x: width, y: point.y + (height - point.y) * (1 - mtControlPointRatio)))
        
        path.addLineToPoint(CGPoint(x: -mtExtenedEdgesOffset, y: height + mtExtenedEdgesOffset))
        
        path.closePath()
        return path
        
        /*
        //3 points
        //顶点
        path.moveToPoint(CGPoint(x:0,y:-mtExtenedEdgesOffset))
        //中点 顶点cp 中点向顶点cp
        path.addCurveToPoint(point, controlPoint1: CGPoint(x:0,y:point.y * mtControlPointRatio), controlPoint2: CGPoint(x:point.x,y:point.y - mtControlPointPulledDistance))
        //底点 中点向底点cp 底点cp
        path.addCurveToPoint(CGPoint(x:0,y:height + mtExtenedEdgesOffset), controlPoint1: CGPoint(x:point.x,y:point.y + mtControlPointPulledDistance), controlPoint2: CGPoint(x: 0, y: point.y + (height - point.y) * (1 - mtControlPointRatio)))
        */
        
        
    }
    
    // II. MARK - Method 2 - Rounded Path
    func createRoundedPath(width:CGFloat,point:CGPoint) -> UIBezierPath{
        let height = view.bounds.height
        //因为是Rect形变，所以要加width
        let offset = width + point.x
        let path = UIBezierPath()
        
        //5 points
        path.moveToPoint(CGPointZero)
        path.addLineToPoint(CGPoint(x: width, y: 0))
        path.addCurveToPoint(CGPoint(x: offset, y: point.y), controlPoint1: CGPoint(x: width, y: 0), controlPoint2: CGPoint(x: offset, y: point.y - mtControlPointRoundedDistance))
        path.addCurveToPoint(CGPoint(x: width, y: height), controlPoint1: CGPoint(x: offset, y: point.y + mtControlPointRoundedDistance), controlPoint2: CGPoint(x: width, y: height))
        path.addLineToPoint(CGPoint(x: 0, y: height))
        
        path.closePath()
        return path
        
    }
    
    // III. MARK - Method 3 松手后的返回动画方法 for Method 1
    func animateShapeLayerToPath(path: CGPathRef, duration: NSTimeInterval) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = path
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.8, 1, 1)
        
        shapeLayer.addAnimation(animation, forKey: "morph")
    }
    
    // IV. MARK - Method 4 松手后的返回动画方法 for Method 2
    
    func animateShapeLayerWithKeyFrames(values:[AnyObject],times:[CGFloat],duration:NSTimeInterval){
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "path")
        keyFrameAnimation.fillMode = kCAFillModeForwards
        keyFrameAnimation.removedOnCompletion = false
        keyFrameAnimation.values = values
        keyFrameAnimation.keyTimes = times
        keyFrameAnimation.duration = duration
        
        shapeLayer.addAnimation(keyFrameAnimation, forKey: "morph")
        
        
    }
    
    
    
    //4.handle Pan Gesture
    func handlePan(pan:UIPanGestureRecognizer){
        let location = pan.locationInView(view)
        switch pan.state{
        case .Began:
            //移除所有动画
            shapeLayer.removeAllAnimations()
            
            //(1).如果抽屉没有打开，且在范围内，跟踪
            if state == .Collapsed && location.x < mtCaptureDistance{
                tracking = true
                print("Began Case closed")
            }
            //(2).如果抽屉已经打开，且手指在右边一定范围内，跟踪
            else if state == .Expanded && location.x > mtDrawerWidth - mtCaptureDistance {
                tracking = true
                print("Began Case opened")
            }
            //(3).其余不动
            else{
                shapeLayer.path = nil
                print("Began Case nothing")
            }
            
            if tracking{
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                    [overlayview] in
                    overlayview.alpha = 1
                    }, completion: nil)
                
                fallthrough
            }

            
        case .Changed:
            //(1). 如果停止跟踪，则返送当前数值
            if !tracking {
                return
            }
            //(2)如果抽屉关闭，且超出一定范围，触发打开效果，但不X位移,回弹，并停止状态跟踪
            if state == .Collapsed && location.x > mtThresholdRatio * mtDrawerWidth{
                tracking = false
                
                let centerY = view.bounds.height/2
                animateShapeLayerWithKeyFrames([
                    shapeLayer.path!,
                    createRoundedPath(mtDrawerWidth, point: CGPoint(x: 30, y: (location.y+centerY)/2)).CGPath,
                    createRoundedPath(mtDrawerWidth, point: CGPoint(x: -30, y: centerY)).CGPath,
                    createRoundedPath(mtDrawerWidth, point: CGPoint(x: 0, y: centerY)).CGPath
                    ], times: [0, 0.5, 0.8, 1.0], duration: 0.3)
                
                state = .Expanded
                
                print("Huge Change->")
                
            }
            //(3)如果抽屉打开状态，且超出一定范围，触发关闭效果，但不X位移,回弹，并停止状态跟踪
            else if state == .Expanded && location.x < (1-mtThresholdRatio) * mtDrawerWidth{
                tracking = false
                
                let centerY = view.bounds.height/2
                animateShapeLayerWithKeyFrames([
                    shapeLayer.path!,
                    createRoundedPath(0, point: CGPoint(x: 30, y: (location.y+centerY)/2)).CGPath,
                    createRoundedPath(0, point: CGPoint(x: -30, y: centerY)).CGPath,
                    createRoundedPath(0, point: CGPoint(x: 0, y: centerY)).CGPath
                    ], times: [0, 0.5, 0.8, 1.0], duration: 0.3)
                
                state = .Collapsed
                
                print("<-Huge Change")
                
                //处理覆盖层
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                    [overlayview] in
                    overlayview.alpha = 0
                    }, completion: nil)
            }
            //(4)未触发位移的正常滑动状态
            else{
                //未触发状态的左滑
                if state == .Collapsed {
                    let point = CGPoint (x:location.x * 0.5,y:location.y)
                    shapeLayer.path = createPulledPath(0, point: point).CGPath
                    
                    //print("->>>>>")
                }
                //未触发状态的右滑, -max->取最左面的点
                else{
                    let point = CGPoint (x:-max(0,mtDrawerWidth - location.x) * 0.5,y:location.y)
                    shapeLayer.path = createPulledPath(mtDrawerWidth, point: point).CGPath
                    
                    //print("<<<<<<-")
                }
                
            }
                
        
            
            
        case .Ended:
            fallthrough
        //*******半路取消的返回
        case .Cancelled:
            
            if tracking{
                //移到右边缘
                //平移点
                let point = CGPoint(x:0,y:location.y)
                animateShapeLayerToPath(createPulledPath(state == .Collapsed ? 0 : mtDrawerWidth, point: point).CGPath, duration: 0.2)
                tracking = false
                
                
                
                if state == .Collapsed{
                    //底部覆盖层根据手势的变化
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                        //***
                        [overlayview] in
                        overlayview.alpha = 0
                        }, completion: nil)
                    print("CLOSED!")
                }
                else{
                    print("OPENED!")
                }
            }
        default:
             ()
        }
    }
    
    //2.View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        //add subview
        view.addSubview(overlayview)
        view.addSubview(drawerView)
        //add mask
        drawerView.layer.mask = shapeLayer
        overlayview.alpha = 0
        //add gesture
        let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
        view.addGestureRecognizer(pan)
    }
    
    //3.layout setting
    override func viewWillLayoutSubviews() {
        overlayview.frame = view.bounds
        drawerView.frame = view.bounds
    }

    //4.Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}

