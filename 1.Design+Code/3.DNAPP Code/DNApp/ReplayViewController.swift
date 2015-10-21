//
//  ReplayViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/21.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

protocol ReplyViewControllerDelegate:class{
    func replyViewControllerDidSend(controller:ReplayViewController)
}

class ReplayViewController: UIViewController {

    var story: JSON = []
    var comment: JSON = []
    
    weak var delegate:ReplyViewControllerDelegate?
    @IBOutlet weak var replyTextView: UITextView!
    @IBAction func sendButtonDidTouch(sender: AnyObject) {
        view.showLoading()
        let token = LocalStore.getToken()!
        let body = replyTextView.text
        
        //评论Story如果成功，动画，如果失败，动画
        if let storyId = story["id"].int {
            DNService.replyStoryWithId(storyId, token: token, body: body, response: { (successful) -> () in
                self.view.hideLoading()
                if successful {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.showAlert()
                }
            })
        }
        
        //评论Comment如果成功，动画，如果失败，动画
        if let commentId = comment["id"].int {
            DNService.replyCommentWithId(commentId, token: token, body: body, response: { (successful) -> () in
                self.view.hideLoading()
                if successful {
                    self.dismissViewControllerAnimated(true, completion: nil)
                    self.delegate?.replyViewControllerDidSend(self)
                } else {
                    self.showAlert()
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //bring up the keyboard
        replyTextView.becomeFirstResponder()
    }
    
    //Alert VC
    func showAlert() {
        let alert = UIAlertController(title: "Oh noes.", message: "Something went wrong. Your message wasn't sent. Please try again and save your text just in case.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
