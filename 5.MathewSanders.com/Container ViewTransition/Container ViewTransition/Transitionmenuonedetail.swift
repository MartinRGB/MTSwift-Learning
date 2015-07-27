//
//  Transitiontwodetail.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/25.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class Transitionmenuonedetail: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToViewController4 (sender: UIStoryboardSegue){
        
        //manually dismiss the screen ，手动取消
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
