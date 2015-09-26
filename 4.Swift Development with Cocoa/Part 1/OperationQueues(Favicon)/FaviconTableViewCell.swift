//
//  FaviconTableViewCell.swift
//  OperationQueues
//
//  Created by Martin on 15/7/18.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class FaviconTableViewCell: UITableViewCell {

    //此队列运行下载的完成处理器
    var operationQueue : NSOperationQueue?

    //此单元格显示的URL
    var url:NSURL?{
        //当URL变化时，运行此代码
    didSet{
            //创建一个请求
            let request = NSURLRequest(URL: self.url!)
            
            //显示URL文本
            self.textLabel?.text = self.url?.host
        
        //发出请求，并给它一个完成处理器 和在上面运行的队列
        let loadedData = NSURLSession.sharedSession()
        
        loadedData.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            //data已加载数据 转化为图像
            let image = UIImage(data:data!)
            //UI更新必须在主队列
            NSOperationQueue.mainQueue().addOperationWithBlock(){
                //将已经加载的图像赋予图像视图
                self.imageView?.image = image
                //可能新图像会改变迟勋，所欲需要重新调整单元格布局
                self.setNeedsLayout()
            }
                    
            //发出请求，并给它一个完成处理器 和在上面运行的队列
            /*
            NSURLConnection.sendAsynchronousRequest(request,
                queue: self.operationQueue!,
                completionHandler: {
                    (response: NSURLResponse!, data: NSData!, error: NSError!) in
            //data已加载数据 转化为图像
            var image = UIImage(data:data)
            //UI更新必须在主队列
            NSOperationQueue.mainQueue().addOperationWithBlock(){
                //将已经加载的图像赋予图像视图
                self.imageView?.image = image
                //可能新图像会改变迟勋，所欲需要重新调整单元格布局
                self.setNeedsLayout()
                    }

                    
            })*/
       
           
        
        }
    }
    
    
}
}