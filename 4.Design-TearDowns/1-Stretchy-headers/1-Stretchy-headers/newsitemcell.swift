//
//  newsitemcell.swift
//  1-Stretchy-headers
//
//  Created by KingMartin on 15/9/21.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class newsitemcell: UITableViewCell {

    @IBOutlet weak var categorylabels: UILabel!
    @IBOutlet weak var summarylabels: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /*
    Swift allows us to include logic under didSet (known as a Property Observer), which will get triggered when the property is set. In this case, we are using this hook to update the labels in the cell.
    */
    var newsItem:NewsItem?{
        didSet{
            if let item = newsItem{
                categorylabels.text = item.category.toString()
                categorylabels.textColor = item.category.toColor()
                summarylabels.text = item.summary
            }
            else{
                categorylabels.text = nil
                summarylabels.text = nil
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
