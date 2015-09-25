//
//  DetailViewController.swift
//  Rooms
//
//  Created by KingMartin on 15/9/25.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var closebtn: UIButton!
    
    //内容View
    let contentView = UIView()
    private let ContentViewTopOffset: CGFloat = 64
    private let ContentViewBottomOffset: CGFloat = 64
    private let ContentViewAnimationDuration: NSTimeInterval = 1.4
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //容器View,增加容器View的shadow
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.frame = CGRect(x:0,y:ContentViewTopOffset,width:view.bounds.width,height:view.bounds.height - ContentViewTopOffset)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSizeZero
        
        view.addSubview(contentView)
        view.addSubview(closebtn)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func handleCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
