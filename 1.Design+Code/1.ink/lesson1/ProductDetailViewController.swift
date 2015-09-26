//
//  ProductDetailViewController.swift
//  lesson1
//
//  Created by Martin on 15/7/6.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate {

    @IBOutlet var webview: UIWebView!
    
    @IBOutlet weak var nav: UIImageView!
    
    @IBOutlet weak var btn: UIButton!
    
    var previousTableViewYOffset : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL (string: "https://auphonic.com/?ref=producthunt")
        let requestObj = NSURLRequest(URL: url!)
        webview.loadRequest(requestObj)
        
        webview.delegate = self
        webview.scrollView.delegate = self
        
        self.tabBarController?.tabBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.nav.frame.origin.y = 0
        webview.scrollView.contentOffset.y = 0        
    }
    

    
    //press back
    @IBAction func backbtn(sender: AnyObject) {
        
        self.tabBarController?.tabBar.hidden = false
        
        self.navigationController!.popViewControllerAnimated(true)
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
            self.tabBarController?.tabBar.frame.origin.y = 520
            }, completion: { finished in
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //scroll to hide and show
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        previousTableViewYOffset = webview.scrollView.contentOffset.y
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        if(webview.scrollView.contentOffset.y > 100){
            if(webview.scrollView.contentOffset.y < previousTableViewYOffset)
            {
                print("0")
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                    self.nav.frame.origin.y = 0
                    self.btn.frame.origin.y = 15
                    self.webview.frame.origin.y = 53
                    }, completion: { finished in
                })
                
                
            }
            else{
                print("1")
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                    self.nav.frame.origin.y = -53
                    self.btn.frame.origin.y = -38
                    self.webview.frame.origin.y = 0
                    }, completion: { finished in
                })
                
            }
        }
        
        
    }


}
