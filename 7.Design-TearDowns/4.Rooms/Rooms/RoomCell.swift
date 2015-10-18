//
//  RoomCell.swift
//  Rooms
//
//  Created by KingMartin on 15/9/26.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class RoomCell: UICollectionViewCell {
    let detailView = DetailView(frame:CGRectZero)
    
    override init(frame:CGRect){
        super.init(frame:frame)
        setup()
    }
    
    required init(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)!
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    func setup(){
        backgroundColor = UIColor.clearColor()
        contentView.addSubview(detailView)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSizeZero
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screenBounds = UIScreen.mainScreen().bounds
        //缩小至零点几倍
        let scale = bounds.width / screenBounds.width
        
        detailView.transitionProgress = 1
        detailView.frame = screenBounds
        detailView.transform = CGAffineTransformMakeScale(scale, scale)
        //居中
        detailView.center = CGPoint(x: bounds.width/2, y: bounds.height/2)
    }
    
}
