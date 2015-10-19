//
//  SocialItemCell.swift
//  Zooming-Icons
//
//  Created by KingMartin on 15/9/23.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class SocialItemCell:UICollectionViewCell{
    @IBOutlet weak var imageview:UIImageView!
    @IBOutlet weak var coloredView:UIView!
    
    var item:SocialItem?{
        didSet{
            if let item = item{
                coloredView.backgroundColor = item.color
                imageview.image = item.image
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coloredView.layer.cornerRadius = bounds.width/2
        coloredView.layer.masksToBounds = true
    }
    
}
