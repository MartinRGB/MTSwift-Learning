//
//  PhotoDetailViewController.swift
//  lesson1
//
//  Created by Martin on 15/7/6.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.hidden = true
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    //press back&btn to show
    @IBAction func backbtn(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
        
        self.tabBarController?.tabBar.hidden = false
        
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

}
