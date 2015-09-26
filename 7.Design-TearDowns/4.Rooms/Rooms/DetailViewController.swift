//
//  DetailViewController.swift
//  Rooms
//
//  Created by KingMartin on 15/9/25.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

private let ContentViewTopOffset: CGFloat = 64
private let ContentViewBottomOffset: CGFloat = 64
private let ContentViewAnimationDuration: NSTimeInterval = 1.4

class DetailViewController: UIViewController ,TransitionManagerViewController{

    @IBOutlet weak var detailView: DetailView!
    @IBOutlet weak var closebtn: UIButton!
    //获取room数据
    var room:RoomModel?
    //内容View
    let contentView = UIView()
    let panelTransition = TransitionManager()
    
    
  
    @IBAction func handleCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func handlePan(pan:UIPanGestureRecognizer){
        switch pan.state{
            
        case.Began:
            fallthrough
        case.Changed:
            contentView.frame.origin.y += pan.translationInView(view).y
            pan.setTranslation(CGPointZero, inView: view)
            
            let progress = (contentView.frame.origin.y - ContentViewTopOffset)/(view.bounds.height - ContentViewBottomOffset - ContentViewTopOffset)
            detailView.transitionProgress = progress
            
        case.Ended:
            fallthrough
        case.Cancelled:
            let progress = (contentView.frame.origin.y - ContentViewTopOffset)/(view.bounds.height - ContentViewBottomOffset - ContentViewTopOffset)
            
            print("\(progress)")
            
            if progress > 0.5 && progress <= 1{
                let duration = NSTimeInterval(1-progress) * ContentViewAnimationDuration + 0.2
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {() -> Void in
                    [self]
                    self.detailView.transitionProgress = 1
                    self.contentView.frame.origin.y = self.view.bounds.height - ContentViewBottomOffset
                    }, completion: nil)
                
            }
            else if progress <= 0.5 && progress > 0{
                
                //动画时间根据Progress
                let duration = NSTimeInterval(progress) * ContentViewAnimationDuration + 0.2
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {() -> Void in
                    [self]
                    self.detailView.transitionProgress = 0
                    self.contentView.frame.origin.y = ContentViewTopOffset
                    }, completion: nil)
            }
            else if progress > 1{
                
                let duration = NSTimeInterval(progress - 1) * ContentViewAnimationDuration + 0.2
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {() -> Void in
                    [self]
                    self.detailView.transitionProgress = 1
                    self.contentView.frame.origin.y = self.view.bounds.height - ContentViewBottomOffset
                    }, completion: nil)
                
                
            }
            else if progress <= 0{
                
                let duration = NSTimeInterval(-progress) * ContentViewAnimationDuration + 0.2
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {() -> Void in
                    [self]
                    self.detailView.transitionProgress = 0
                    self.contentView.frame.origin.y = ContentViewTopOffset
                    }, completion: nil)
            }
            
        default:
            ()
            
        }
    }
    //status bar color
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //容器View,增加容器View的shadow
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.frame = CGRect(x:0,y:ContentViewTopOffset,width:view.bounds.width,height:view.bounds.height - ContentViewTopOffset)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSizeZero

        //从其他VC取数
        
        //***********In Swift, everything is public by default. Define your variables outside the classes:
        var number:Int! = selectedIndexPath?.row
        var number2:Int = number + 1
        
        print("a\(number2)")
        
        let imageView = UIImageView(image: UIImage(named: "a\(number2)"))
        imageView.frame = CGRectMake(0, 0,contentView.frame.width,contentView.bounds.height)
        //填充模式
        imageView.contentMode = .ScaleAspectFill
        contentView.addSubview(imageView)
        
        view.addSubview(contentView)
        view.addSubview(closebtn)
        
        // add pan gesture
        let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
        view.addGestureRecognizer(pan)
        
        //转场委托
        detailView.room = room
        transitioningDelegate = panelTransition
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: TransitionManagerViewController
    func transitionMangagerDetailViewForTransition(transition: TransitionManager) -> DetailView! {
        return detailView
    }
    
    func transitionManagerWillANimateTransition(transition: TransitionManager, presenting: Bool, isFG: Bool) {
        
        if presenting {
            
            contentView.frame.origin.y = view.bounds.height
            closebtn.alpha = 0
            
            UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                [self]
                self.contentView.frame.origin.y = ContentViewTopOffset
                self.closebtn.alpha = 1
                }, completion: nil)
        }
        else {
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                [self]
                self.contentView.frame.origin.y = self.view.bounds.height
                self.closebtn.alpha = 0
                }, completion: nil)
        }
    }
    
    
    
    
}
