//
//  FloatingMenuController.swift
//  6.Expanding-Cells
//
//  Created by KingMartin on 15/10/9.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

//introduce delegate we can get notified when the buttons are tapped.
@objc
protocol FloatingMenuControllerDelegate: class {
    //获取点击Index
    optional func floatingMenuController(controller: FloatingMenuController, didTapOnButton button: UIButton, atIndex index: Int)
    //Cancel VC
    optional func floatingMenuControllerDidCancel(controller: FloatingMenuController)
}


class FloatingMenuController: UIViewController {
    
    //MARK:Btn附近的布局
    enum Direction {
        case Up
        case Down
        case Left
        case Right
        //**
        func offsetPoint(point: CGPoint, offset: CGFloat) -> CGPoint {
            switch self {
            case .Up:
                return CGPoint(x: point.x, y: point.y - offset)
            case .Down:
                return CGPoint(x: point.x, y: point.y + offset)
            case .Left:
                return CGPoint(x: point.x - offset, y: point.y)
            case .Right:
                return CGPoint(x: point.x + offset, y: point.y)
            }
        }
    }

    ///**开启后所有BTN的Delegate
    weak var delegate: FloatingMenuControllerDelegate?
    
    ///**开始3view
    let fromView:UIView
    let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
    let closebtn = FloatingButton(image: UIImage(named:"icon-close"), backgroundColor: UIColor.flatRedColor)
    
    ///**BUTTON
    var buttonDirection = Direction.Up
    var buttonPadding:CGFloat = 70
    //Button组
    var buttonItems=[UIButton]()
    
    //**Label
    var labelDirection = Direction.Left
    //Label String名称
    var labelTitles = [String]()
    //Label组
    var buttonLabels = [UILabel]()
    
    //**************************只需要定义两种状态，然后动画两种状态实现切换,注意Label的间距关系
    func configureButtons(initial: Bool) {
        //configure Position
        let parentController = presentingViewController!
        let center = parentController.view.convertPoint(fromView.center, fromView: fromView.superview)
        
        closebtn.center = center
        
        if initial {
            //alpha=0,旋转度
            closebtn.alpha = 0
            closebtn.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            
            //居于一个位置
            for (_, button) in buttonItems.enumerate() {
                button.center = center
                button.alpha = 0
                button.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            }
            
            for (index, label) in buttonLabels.enumerate() {
                let buttonCenter = buttonDirection.offsetPoint(center, offset: buttonPadding * CGFloat(index+1))
                
                let labelSize = labelDirection == .Up || labelDirection == .Down ? label.bounds.height : label.bounds.width
                let labelCenter = labelDirection.offsetPoint(buttonCenter, offset: buttonPadding/2 + labelSize)
                label.center = labelCenter
                label.alpha = 0
            }
        }
        else {
            closebtn.alpha = 1
            closebtn.transform = CGAffineTransformIdentity
            
            for (index, button) in buttonItems.enumerate() {
                let buttonCenter = buttonDirection.offsetPoint(center, offset: buttonPadding * CGFloat(index+1))
                button.center = buttonCenter
                button.alpha = 1
                button.transform = CGAffineTransformIdentity
            }
            //******************
            for (index, label) in buttonLabels.enumerate() {
                let buttonCenter = buttonDirection.offsetPoint(center, offset: buttonPadding * CGFloat(index+1))
                
                let labelSize = labelDirection == .Up || labelDirection == .Down ? label.bounds.height : label.bounds.width
                let labelCenter = labelDirection.offsetPoint(buttonCenter, offset: buttonPadding/2 + labelSize/2)
                label.center = labelCenter
                label.alpha = 1
            }
        }
    }
    //**************************
    func animateButtons(visible: Bool) {
        configureButtons(visible)
        
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            [self]
            self.configureButtons(!visible)
            }, completion: nil)
    }
    
    //MARK : Define fromView and TransitionStyle
    init(fromView:UIView){
        self.fromView = fromView
        super.init(nibName:nil,bundle:nil)
        //保留之前VC
        modalPresentationStyle = .OverFullScreen
        //alpha变化
        modalTransitionStyle = .CrossDissolve
    }
    
    //Stroyboard中需要的初始化,因为FromVC是从Xib加载的
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //***MARK**
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //保留后只需要加blurredView即可
        blurredView.frame = view.bounds
        //h1
        view.addSubview(blurredView)
        //h2
        view.addSubview(closebtn)
        
        closebtn.addTarget(self, action: "FABonclose:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //将button组的每一个button加载到self.view中,并添加按钮效果
        for button in buttonItems{
            button.addTarget(self, action: "FABmenuonclick:", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(button)
        }
        
        //将label组的每一个label加载到self.view中
        for title in labelTitles{
            let label = UILabel()
            label.text = title
            label.textColor = UIColor.flatBlackColor
            label.textAlignment = .Center
            label.font = UIFont(name: "HelveticaNeue-Light", size: 15)
            label.backgroundColor = UIColor.flatWhiteColor
            label.sizeToFit()
            label.bounds.size.height += 8
            label.bounds.size.width += 20
            label.layer.cornerRadius = 4
            label.layer.masksToBounds = true
            view.addSubview(label)
            buttonLabels.append(label)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        animateButtons(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        animateButtons(false)
    }
    
    //MARK:BTN事件
    //close本身
    func FABonclose (sender:AnyObject){
        delegate?.floatingMenuControllerDidCancel?(self)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //将点击的Index返送给MainVC，同时引发MainVC的Controller.dismiss....
    func FABmenuonclick (sender:AnyObject){
        let button = sender as! UIButton
        if let index = buttonItems.indexOf(button) {
            delegate?.floatingMenuController?(self, didTapOnButton: button, atIndex: index)
        }
    }
    

}

