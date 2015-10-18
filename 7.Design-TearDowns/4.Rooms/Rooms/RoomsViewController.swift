//
//  ViewController.swift
//  Rooms
//
//  Created by KingMartin on 15/9/24.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

let RoomCellScaling:CGFloat = 0.6
var selectedIndexPath: NSIndexPath?

class RoomsViewController: UICollectionViewController,TransitionManagerViewController {
    
    
    //导入数据模型，加载数据
    let rooms = [
        RoomModel(title: "Diving", subtitle: "Hold your breath", image: UIImage(named: "1"), color: UIColor(red: 0.2594, green: 0.3019, blue: 0.3367, alpha: 0.7)),
        RoomModel(title: "Walk alone", subtitle: "One person,one road", image: UIImage(named: "2"), color: UIColor(red: 0.6833, green: 0.4143, blue: 0.1902, alpha: 0.7)),
        RoomModel(title: "Coffee Time", subtitle: "Great history of cocoa", image: UIImage(named: "3"), color: UIColor(red: 110/255.0, green: 109/255.0, blue: 117/255.0, alpha: 0.7)),
        RoomModel(title: "Outdoors", subtitle: "Let's go outside", image: UIImage(named: "4"), color: UIColor(red: 76/255.0, green: 57/255.0, blue: 80/255.0, alpha: 0.7)),
        RoomModel(title: "Find a place", subtitle: "Where you can have a rest", image: UIImage(named: "5"), color: UIColor(red: 56/255.0, green: 77/255.0, blue: 80/255.0, alpha: 0.7)),
        RoomModel(title: "Breakfast", subtitle: "The first important things of one day", image: UIImage(named: "6"), color: UIColor(red: 56/255.0, green: 57/255.0, blue: 80/255.0, alpha: 0.7))
    ]
    
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
        
        
        //collectionView?.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    //numberofitemsin section
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    //cellforitematindexpath 解读Identifier以及数据模型中的数据 制造Cell
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! RoomCell
        cell.detailView.room = rooms[indexPath.item]
        return cell
    }
    
    
    //MARK:UIScrollViewDelegate
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
        
        //**********************reason*********************
        selectedIndexPath = indexPath
        
        //拿到DetailVC的数据
        let controller = UIStoryboard(name:"Main",bundle:nil).instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        controller.room = rooms[indexPath.item]
        presentViewController(controller, animated: true, completion: nil)
    }
    
    // MARK: TransitionManagerViewController

    func transitionMangagerDetailViewForTransition(transition: TransitionManager) ->DetailView! {
        if let indexpath = selectedIndexPath{
            if let cell = collectionView?.cellForItemAtIndexPath(indexpath) as? RoomCell{
                //返送的是detailview
                return cell.detailView
            }
        }
        return nil
    }
    
    

   

}

