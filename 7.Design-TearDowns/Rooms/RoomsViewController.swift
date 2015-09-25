//
//  ViewController.swift
//  Rooms
//
//  Created by KingMartin on 15/9/24.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

let RoomCellScaling:CGFloat = 0.6

class RoomsViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //numberofitemsin section
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    //cellforitematindexpath 解读Identifier，制造Cell
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        return cell
    }
    
    //layout调整
    func setupCollectionView(){
        let screenSize = UIScreen.mainScreen().bounds.size
        
        //向下取整 约定于四舍五入
        let cellWidth = floor(screenSize.width * RoomCellScaling)
        let cellHeight = floor(screenSize.height * RoomCellScaling)
        //刚好居中
        let insetX = (CGRectGetWidth(view.bounds) - cellWidth)/2.0
        let insetY = (CGRectGetHeight(view.bounds) - cellHeight)/2.0
        
        //获取layout
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        //布局调整
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        collectionView?.reloadData()
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //获取Layout
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        //距离＝宽度＋间隙
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumInteritemSpacing
        
        var offset = targetContentOffset.memory
        //获取当前屏幕下的索引号
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        //四舍五入
        let roundedIndex = round(index)
        //每次只移整
        offset = CGPoint(x:roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,y:-scrollView.contentInset.top)
        //读取偏移量
        targetContentOffset.memory = offset
        
    }
    
    //MARK:UICollectionViewDelegate
    //选中后的转场效果
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = UIStoryboard(name:"Main",bundle:nil).instantiateViewControllerWithIdentifier("DetailViewController") as UIViewController
        presentViewController(controller, animated: true, completion: nil)
    }



}

