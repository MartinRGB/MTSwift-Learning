//
//  ViewController.swift
//  Intruduction Tips
//
//  Created by KingMartin on 15/9/27.
//  Copyright © 2015年 KingMartin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        presentTips([
            Tip(title:"Tip #1:Don't Blink",summary: "Fantastic shot of Sarah for the ALS Ice Bucket Challenge - And yes, she tried her hardest not to blink!", image: UIImage(named: "1")),
            Tip(title: "Tip #2: Explore", summary: "Get out of the house!", image: UIImage(named: "2")),
            Tip(title: "Tip #3: Take in the Moment", summary: "Remember that each moment is unique and will never come again.", image: UIImage(named: "3"))],animated:true,completion:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

