//
//  LoginViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/19.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableView!

    @IBAction func closebtndidTouch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        dialogView.animation = "zoomOut"
        dialogView.animate()
    }
    
    @IBAction func loginBtndidtouch(sender: AnyObject) {
        dialogView.animation = "shake"
        dialogView.animate()
    }

}
