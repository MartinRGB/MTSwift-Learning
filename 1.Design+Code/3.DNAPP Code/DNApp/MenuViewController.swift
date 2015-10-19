//
//  MenuViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/19.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableView!
    
  
    @IBAction func closebtndidtouch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        dialogView.animation = "fall"
        dialogView.animate()
        
    }

    @IBAction func learniOS(sender: AnyObject) {
        performSegueWithIdentifier("LearnSegue", sender: self)
    }
}
