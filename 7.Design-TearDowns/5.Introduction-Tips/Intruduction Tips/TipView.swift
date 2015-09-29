//
//  TIpView.swift
//  Intruduction Tips
//
//  Created by KingMartin on 15/9/27.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class TipView: UIView {

    @IBOutlet weak var titlelabel :UILabel!
    @IBOutlet weak var summarylabel :UILabel!
    @IBOutlet weak var imageview :UIImageView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    //Tipview获取Tip的数据模型
    var tip: Tip?{
        didSet{
        titlelabel.text = tip?.title ?? "No Title"
        summarylabel.text = tip?.summary ?? "No Title"
        imageview.image = tip?.image
        }
    }
    //布局
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }
    
    override func alignmentRectForFrame(frame: CGRect) -> CGRect {
        return bounds
    }
}
