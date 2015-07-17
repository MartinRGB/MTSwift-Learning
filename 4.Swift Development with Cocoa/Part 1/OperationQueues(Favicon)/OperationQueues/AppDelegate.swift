//
//  AppDelegate.swift
//  OperationQueues
//
//  Created by Martin on 15/7/18.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    var backgroundTask :UIBackgroundTaskIdentifier?
    //注册后台任务。阻止APP终止
    //知道我们告诉系统，任务已经完成

    func applicationDidEnterBackground(application: UIApplication) {
        self.backgroundTask = application.beginBackgroundTaskWithExpirationHandler{
            () -> Void in
            //清理，然后运行endBackgrounTask
            application.endBackgroundTask(self.backgroundTask!)
            var backgroundQueue = NSOperationQueue()
            backgroundQueue.addOperationWithBlock(){
             //向服务器发送请求，准备URL
                var notificationURL = NSURL(string:"http://www.oreilly.com/")
                
                //准备URL请求
                var notificationURLRequest = NSURLRequest(URL:notificationURL!)
                //发送请求，记录回复
                var loadedData = NSURLConnection.sendSynchronousRequest(notificationURLRequest, returningResponse: nil, error: nil)
                //将数据转换为字符串
                if let theData = loadedData{
                    var loadedString = NSString(data:theData,encoding:NSUTF8StringEncoding)
                    println("Loaded:\(loadedString)")
                }
                //发出信号，说明我们已经完成后台
                application.endBackgroundTask(self.backgroundTask!)
                
            }
        }
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

