//
//  LearnViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/19.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableView!
    
    @IBOutlet weak var thebook: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        dialogView.animate()
    }
    
    @IBAction func closebtn(sender: AnyObject) {
        dialogView.animation = "fall"
        dialogView.animateNext{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func learnbtn(sender: AnyObject) {
        thebook.animation = "pop"
        thebook.animate()
    }
    
    
}
