//
//  IntroViewController.swift
//  lesson1
//
//  Created by Martin on 15/7/1.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

//!!!###
//class IntroViewController: UIViewController,UIScrollViewDelegate
//scrollView.delegate = self

import UIKit

class IntroViewController: UIViewController,UIScrollViewDelegate {

 
    @IBOutlet var introbtn: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    var pageControl : UIPageControl = UIPageControl(frame: CGRectMake(141, 455, 39, 37))
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSizeMake(960, 568)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.delegate = self
       
        

        //Page Control Part
        configurePageControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 222/255.0, green: 75/225.0, blue: 53/255.0, alpha: 0.75)
        self.view.addSubview(pageControl)
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println(scrollView.contentOffset.x)
        if(scrollView.contentOffset.x>=600)
        {
            UIView.animateWithDuration(0.5, delay: 0,usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
                self.introbtn.frame.origin.y = 492
                
                }, completion: { finished in
            })
        }
        else{
            UIView.animateWithDuration(0.5, delay: 0,usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
                self.introbtn.frame.origin.y = 692
                
                }, completion: { finished in
            })
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //round：如果参数是小数，则求本身的四舍五入。 int取整
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        
        
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
