//
//  ViewController.swift
//  Swift DWC－1
//
//  Created by 1 on 15/7/17.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hellobtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func showAlert(sender: AnyObject) {
        
        var alertView = UIAlertView(title: "Hello!", message: "Hello,world!", delegate: self, cancelButtonTitle: "取消")
        alertView.show()
        
        /*
        var alert = UIAlertController(title:"Hello",message:"Hello,world!",preferredStyle:UIAlertControllerStyle.Alert")
        alert.addAction(UIAlertAction(title:"Close",style:UIAlertActionStyle.Default,handler:nil)),
        self.presentViewController(alert,animated: true, completion: nil)
        self.hellobtn.setTitle("Clicked", forState: UIControlState.Normal)*/
        }

}

