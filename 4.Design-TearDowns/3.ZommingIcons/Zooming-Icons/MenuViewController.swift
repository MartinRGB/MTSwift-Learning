//
//  MenuViewController.swift
//  Zooming-Icons
//
//  Created by KingMartin on 15/9/23.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MenuViewController:UICollectionViewController,ZoomingIconViewController{
    
    //know which indexpath we selected
    var selectedIndexPath: NSIndexPath?
    
    //dictionary
    let items = [
        SocialItem(image: UIImage(named: "icon-twitter"), color: UIColor(red: 0.255, green: 0.557, blue: 0.910, alpha: 1), name: "Twitter", summary: "Twitter is an online social networking service that enables users to send and read short 140-character messages called \"tweets\"."),
        SocialItem(image: UIImage(named: "icon-facebook"), color: UIColor(red: 0.239, green: 0.353, blue: 0.588, alpha: 1), name: "Facebook", summary: "Facebook (formerly thefacebook) is an online social networking service headquartered in Menlo Park, California. Its name comes from a colloquialism for the directory given to students at some American universities."),
        SocialItem(image: UIImage(named: "icon-youtube"), color: UIColor(red: 0.729, green: 0.188, blue: 0.180, alpha: 1), name: "Youtube", summary: "YouTube is a video-sharing website headquartered in San Bruno, California. The service was created by three former PayPal employees in February 2005 and has been owned by Google since late 2006. The site allows users to upload, view, and share videos."),
        SocialItem(image: UIImage(named: "icon-vimeo"), color: UIColor(red: 0.329, green: 0.737, blue: 0.988, alpha: 1), name: "Vimeo", summary: "Vimeo is a U.S.-based video-sharing website on which users can upload, share and view videos. Vimeo was founded in November 2004 by Jake Lodwick and Zach Klein."),
        SocialItem(image: UIImage(named: "icon-instagram"), color: UIColor(red: 0.325, green: 0.498, blue: 0.635, alpha: 1), name: "Instagram", summary: "Instagram is an online mobile photo-sharing, video-sharing and social networking service that enables its users to take pictures and videos, and share them on a variety of social networking platforms, such as Facebook, Twitter, Tumblr and Flickr.")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        self.view.backgroundColor = UIColor.whiteColor()
    
    }
    
    // MARK: UICollectionViewDataSource 数据源&处理
    
    //几行 numberofsection
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    //每行几个 numberofitemsinsection
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 0
        }
    }
    //解读Identifier
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath)->UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as!SocialItemCell
        
        //第一行排序1、2 第二行排列
        //0,1
        //2,3,4
        var index = 0
        for s in 0..<indexPath.section{
            index += self.collectionView(collectionView,numberOfItemsInSection: s)
        
        }
        index += indexPath.item
        
        print("\(index)")
        
        let item = items[index]
        cell.item = item
        
        return cell
    }
    
    //layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        //布局
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = layout.itemSize.width
        //获取cell个数
        let numberOfCells = self.collectionView(collectionView, numberOfItemsInSection: section)
        //cell与cell之间的间隙
        let widthOfCells = CGFloat(numberOfCells) * layout.itemSize.width + CGFloat(numberOfCells-1) * layout.minimumInteritemSpacing
        
        //cell与屏幕左右的间距
        let inset = (collectionView.bounds.width - widthOfCells) / 2.0
        return UIEdgeInsets(top: 0, left: inset, bottom: 40, right: inset)
    }
    
    // MARK: UICollectionViewDelegate
    
    //转场进入DetailVC
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
       
        selectedIndexPath = indexPath
        print("\(selectedIndexPath)")
        
        var index = 0
        for s in 0..<indexPath.section{
            index += self.collectionView(collectionView,numberOfItemsInSection: s)
        }
        index += indexPath.item
        //让item数据从MenuVC传入到DetailVC
        let item = items[index]
        let controller = UIStoryboard(name:"Main",bundle:nil).instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        controller.item = item
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
    //根据Protocol提供color
    func zoomingIconColoredViewForTransition(transition: ZoomingIconTransition) -> UIView! {
        if let indexPath = selectedIndexPath {
            let cell = collectionView!.cellForItemAtIndexPath(indexPath) as! SocialItemCell
            return cell.coloredView
        }
        //否则使用Custom
        else {
            return nil
        }
    }
    
    //根据Protocol提供imageview
    func zoomingIconImageViewForTransition(transition: ZoomingIconTransition) -> UIImageView! {
        if let indexPath = selectedIndexPath {
            let cell = collectionView!.cellForItemAtIndexPath(indexPath) as! SocialItemCell
            return cell.imageview
        }
        //否则使用Custom
        else {
            return nil
        }
    }
    


}



