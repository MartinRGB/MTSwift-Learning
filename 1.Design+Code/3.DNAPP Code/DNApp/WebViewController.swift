//
//  WebViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/20.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    var story:JSON!
    var url: String!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressView: UIProgressView!
    var hasFinishedLoading = false
    
    @IBAction func closeButtonDidTouch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let targetURL = NSURL(string: url)
        let request = NSURLRequest(URL:targetURL!)
        webView.loadRequest(request)
        
        webView.delegate = self
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        hasFinishedLoading = false
        updateProgress()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        delay(1) { [weak self] in
            if let _self = self {
                _self.hasFinishedLoading = true
            }
        }
    }
    //反初始化
    deinit {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    func updateProgress() {
        if progressView.progress >= 1 {
            progressView.hidden = true
        } else {
            //进度值越大，增幅越小
            if hasFinishedLoading {
                progressView.progress += 0.002
            } else {
                if progressView.progress <= 0.3 {
                    progressView.progress += 0.004
                } else if progressView.progress <= 0.6 {
                    progressView.progress += 0.002
                } else if progressView.progress <= 0.9 {
                    progressView.progress += 0.001
                } else if progressView.progress <= 0.94 {
                    progressView.progress += 0.0001
                } else {
                    progressView.progress = 0.9401
                }
            }
            
            delay(0.008) { [weak self] in
                if let _self = self {
                    _self.updateProgress()
                }
            }
        }
    }
    


}
