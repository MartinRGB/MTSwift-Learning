//
//  LoginViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/19.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var dialogView: DesignableView!
    
    
    @IBOutlet weak var passwordimageview: SpringImageView!
    @IBOutlet weak var emailimageview: SpringImageView!
    @IBOutlet weak var emailtextfield: DesignableTextField!
    @IBOutlet weak var passwordtextfield: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailtextfield.delegate = self
        passwordtextfield.delegate = self
    }
    

    @IBAction func closebtndidTouch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        dialogView.animation = "zoomOut"
        dialogView.animate()
    }
    
    @IBAction func loginBtndidtouch(sender: AnyObject) {
        dialogView.animation = "shake"
        dialogView.animate()
    }
    //dismiss the keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == emailtextfield {
            emailimageview.image = UIImage(named: "icon-mail-active")
            emailimageview.animate()
        } else {
            emailimageview.image = UIImage(named: "icon-mail")
        }
        
        if textField == passwordtextfield {
            passwordimageview.image = UIImage(named: "icon-password-active")
            passwordimageview.animate()
        } else {
            passwordimageview.image = UIImage(named: "icon-password")
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        emailimageview.image = UIImage(named: "icon-mail")
        passwordimageview.image = UIImage(named: "icon-password")
    }
    
    

}
