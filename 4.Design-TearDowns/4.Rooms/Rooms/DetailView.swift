//
//  DetailView.swift
//  Rooms
//
//  Created by KingMartin on 15/9/25.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit
//使用IBDesignable将.swift导入到SB
@IBDesignable class DetailView: UIView {

    //imageview
    let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        return  imageView
    }()
    //覆盖层
    let overlayView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.655, green: 0.737, blue: 0.835, alpha: 0.8)
        return view
    }()
    //标题
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        return label
    }()
    //副标题
    let subtitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(17)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        //自动换行
        label.numberOfLines = 0
        return label
    }()
    
    //做一个进度条
    var transitionProgress:CGFloat = 0{
        didSet{
            updateViews()
        }
    }
    
    var room:RoomModel?{
        didSet{
            if let room = room{
                titleLabel.text = room.title
                subtitleLabel.text = room.subtitle
                imageView.image = room.image
                overlayView.backgroundColor = room.color
            }
        }
    }
    
    
    //设置相关动画参数
    func updateViews(){
        let progress = min(max(transitionProgress, 0), 1)
        let antiProgress = 1.0 - progress
        
        let titleLabelOffsetTop: CGFloat = 20.0
        let titleLabelOffsetMiddle: CGFloat = bounds.height/2 - 44
        //两个Progress相加
        let titleLabelOffset = transitionProgress * titleLabelOffsetMiddle + antiProgress * titleLabelOffsetTop
        
        let subtitleLabelOffsetTop: CGFloat = 64
        let subtitleLabelOffsetMiddle: CGFloat = bounds.height/2
        let subtitleLabelOffset = transitionProgress * subtitleLabelOffsetMiddle + antiProgress * subtitleLabelOffsetTop
        
        titleLabel.frame = CGRect(x: 0, y: titleLabelOffset, width: bounds.width, height: 44)
        subtitleLabel.preferredMaxLayoutWidth = bounds.width
        subtitleLabel.frame = CGRect(x: 0, y: subtitleLabelOffset, width: bounds.width, height: subtitleLabel.font.lineHeight)
        
        imageView.alpha = progress
        
    }
    
    
    
    
    // If the view is unarchived from a storyboard or nib file, we should use awakeFromNib(). &init
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    //设置view
    func setup(){
        addSubview(imageView)
        addSubview(overlayView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        clipsToBounds = true
        
        titleLabel.text = "Title of Room"
        subtitleLabel.text = "Description of Room"
        imageView.image = UIImage(named:"bicycle-garage-gray")
        
    }
    
    //layout Update
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
        overlayView.frame = bounds
        updateViews()
    }

}

