//
//  MenuViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/19.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit
//delegate
protocol MenuViewControllerDelegate:class{
    func menuViewControllerDidTouchTop(controller:MenuViewController)
    func menuViewControllerDidTouchRecent(controller:MenuViewController)
}

class MenuViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableView!
    //Create a Delegate so that we can communicate back to the Stories screen.
    weak var delegate: MenuViewControllerDelegate?
    
  
    @IBAction func closebtndidtouch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        dialogView.animation = "fall"
        dialogView.animate()
        
    }

    @IBAction func learniOS(sender: AnyObject) {
        performSegueWithIdentifier("LearnSegue", sender: self)
    }
    
    
    @IBAction func topbtndidtouch(sender: AnyObject) {
        delegate?.menuViewControllerDidTouchTop(self)
        closebtndidtouch(sender)
    }
    
    
    @IBAction func recentbtndidtouch(sender: AnyObject) {
        delegate?.menuViewControllerDidTouchRecent(self)
        closebtndidtouch(sender)
    }
    
    @IBAction func loginbtndidtouch(sender: AnyObject) {
        performSegueWithIdentifier("LoginSegue2", sender: self)
    }
    
    
    
}
