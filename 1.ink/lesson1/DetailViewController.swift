//
//  DetailViewController.swift
//  lesson1
//
//  Created by Martin on 15/7/2.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet var btn: UIButton!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var text: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollview.contentSize = CGSizeMake(375, 1870)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //用按钮触发push返回
    @IBAction func doback(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
    }

}
