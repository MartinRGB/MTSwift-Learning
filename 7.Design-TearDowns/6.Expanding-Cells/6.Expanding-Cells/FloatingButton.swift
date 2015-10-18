//
//  FloatingButton.swift
//  6.Expanding-Cells
//
//  Created by KingMartin on 15/10/9.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

//定义FloatingButton这个类
class FloatingButton:UIButton {
    
    //init the FloatingButton
    convenience init(image: UIImage?, backgroundColor: UIColor = UIColor.flatBlueColor) {
        self.init()
        setImage(image, forState: .Normal)
        setBackgroundImage(backgroundColor.pixelImage, forState: .Normal)
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        setup()
    }
    //????
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    //set the backgroundColor
    func setup() {
        tintColor = UIColor.whiteColor()
        if backgroundImageForState(.Normal) == nil {
            setBackgroundImage(UIColor.flatBlueColor.pixelImage, forState: .Normal)
        }
        
        layer.cornerRadius = frame.width/2
        layer.masksToBounds = true
    }
}
