//
//  ViewController.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/18.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    let Effectname = ["Effect 1","Effect 2","Effect 3","Effect 4","Effect 5"]
    
    let textCellIdentifier = "TextCell"
    
    //每栏行数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //多少栏
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Effectname.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = Effectname[row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func unwindtoViewController (sender:UIStoryboardSegue){
        
    }

}

