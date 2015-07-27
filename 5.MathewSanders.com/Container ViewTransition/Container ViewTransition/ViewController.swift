//
//  ViewController.swift
//  Container ViewTransition
//
//  Created by 1 on 15/7/18.
//  Copyright (c) 2015年 1. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    let Effectname = ["Animation 1","Animation 2","Animation 3","Animation 4","Transition 1","Transition 2","Transition 3"]
    
    let textCellIdentifier = "TextCell"
    
    //在本例中，只有一个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    //多少行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Effectname.count
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //同一形式的单元格重复使用
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        //每一行的名字
        let row = indexPath.row
        cell.textLabel?.text = Effectname[row]
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView:UITableView!,didSelectRowAtIndexPath indexPath:NSIndexPath!)
    {
        println("You selected cell #\(indexPath.row)!")
        if indexPath.row == 0{
            self.performSegueWithIdentifier("effect1", sender: indexPath.row)
        }
        if indexPath.row == 1{
            self.performSegueWithIdentifier("effect2", sender: indexPath.row)
        }
        if indexPath.row == 2{
            self.performSegueWithIdentifier("effect3", sender: indexPath.row)
        }
        if indexPath.row == 3{
            self.performSegueWithIdentifier("effect4", sender: indexPath.row)
        }
        if indexPath.row == 4{
            self.performSegueWithIdentifier("effect5", sender: indexPath.row)
        }
        
        if indexPath.row == 5{
            self.performSegueWithIdentifier("effect6", sender: indexPath.row)
        }
        
        if indexPath.row == 6{
            self.performSegueWithIdentifier("effect7", sender: indexPath.row)
        }
    }
    
    //开启转场
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "effect1"{
            let controller = segue.destinationViewController as! animation1
        }
        if segue.identifier == "effect2"{
            let controller = segue.destinationViewController as! animation2
        }
        if segue.identifier == "effect3"{
            let controller = segue.destinationViewController as! animation3
        }
        if segue.identifier == "effect4"{
            let controller = segue.destinationViewController as! animation4
        }
        if segue.identifier == "effect5"{
            let controller = segue.destinationViewController as! transition1
        }
        
        if segue.identifier == "effect6"{
            let controller = segue.destinationViewController as! transition2
        }
        
        if segue.identifier == "effect7"{
            let controller = segue.destinationViewController as! transition3
        }
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

