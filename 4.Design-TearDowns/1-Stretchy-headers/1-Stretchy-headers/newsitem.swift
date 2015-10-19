//
//  newsitem.swift
//  1-Stretchy-headers
//
//  Created by KingMartin on 15/9/21.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import Foundation
import UIKit

struct NewsItem {
    enum NewsCategory{
        case designernews
        case github
        case alistapart
        case medium
        case sidebario
        case producthunt
        
        func toString() ->String{
            switch self{
            case.designernews:
                return "Designer News"
            case.github:
                return "Github"
            case.alistapart:
                return "A List Apart"
            case.medium:
                return "Medium"
            case.sidebario:
                return "Sidebar.io"
            case.producthunt:
                return "Product Hunt"
            }
        }
        
        
        func toColor() -> UIColor{
            switch self{
            case.designernews:
                return UIColor(red: 0.106, green: 0.686, blue: 0.125, alpha: 1)
            case.github:
                return UIColor(red: 0.114, green: 0.639, blue: 0.984, alpha: 1)
            case.alistapart:
                return UIColor(red: 0.322, green: 0.459, blue: 0.984, alpha: 1)
            case.medium:
                return UIColor(red: 0.502, green: 0.290, blue: 0.984, alpha: 1)
            case.sidebario:
                return UIColor(red: 0.988, green: 0.271, blue: 0.282, alpha: 1)
            case.producthunt:
                return UIColor(red: 0.620, green: 0.776, blue: 0.153, alpha: 1)
            }
        }
        
    }
    let category:NewsCategory
    let summary:String
}
