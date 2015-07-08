//
//  CardDeatilViewController.swift
//  Ink
//
//  Created by 1 on 15/7/8.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

import UIKit

class CardDeatilViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var bckbtn: UIButton!
    @IBOutlet var c1img: UIImageView!
    @IBOutlet var c1detailtext: UIImageView!
    
    var data = Array<Dictionary<String,String>>()
    var number = 0
    var scrolly = 920
    
    override func viewDidLoad() {
        super.viewDidLoad()
        c1img.image = UIImage(named: data[number]["Img"]!)
        c1detailtext.image = UIImage(named: data[number]["DetailText"]!)
        // Do any additional setup after loading the view.
        
        scrollview.contentSize = CGSizeMake(320, 920)
        self.scrollview.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animateWithDuration(0.3, delay: 0,usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.bckbtn.frame = CGRectMake(8, 8, 60, 60)
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
    @IBAction func backbtn(sender: AnyObject) {
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
            self.scrollview.contentOffset.y = 0
            }, completion: { finished in
                self.dismissViewControllerAnimated(false, completion: {})
                
        })
       
    }
    
   
    

}
