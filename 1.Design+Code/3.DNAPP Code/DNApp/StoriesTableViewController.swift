//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by KingMartin on 15/10/19.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController,StoryTableViewCellDelegate,MenuViewControllerDelegate,LoginViewControllerDelegate {
    
    @IBOutlet weak var loginButton: UIBarButtonItem!
    var stories:JSON! = []
    func refreshStories() {
        loadStories(section, page: 1)
        SoundPlayer.play("refresh.wav")
    }
    var isFirstTime = true
    var section = ""
    
    //将获取到的JSON数据填充到指定页的方法
    func loadStories(section: String, page: Int) {
        // When you’re inside a nested function (storiesForSection is considered a function), you have to add the self to avoid conflicts with local and global variables
        DNService.storiesForSection(section, page: page) { (JSON) -> () in
            self.stories = JSON["stories"]
            self.tableView.reloadData()
            self.tableView.hideLoading()
            self.refreshControl?.endRefreshing()
        }
        
        if LocalStore.getToken() == nil {
            loginButton.title = "Login"
            loginButton.enabled = true
        } else {
            loginButton.title = ""
            loginButton.enabled = false
        }
    }
    
    //first time loading the page
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if isFirstTime {
            view.showLoading()
            isFirstTime = false
        }
    }
    
    
    
    let transitionManager = TransitionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        loadStories("", page: 1)
        //添加refresh control事件
        refreshControl?.addTarget(self, action: "refreshStories", forControlEvents: UIControlEvents.ValueChanged)
        
        //Back font
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir Next", size: 18)!], forState: UIControlState.Normal)
        //Login Font
        loginButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir Next", size: 18)!], forState: UIControlState.Normal)
    }
    
    
    
    
    @IBAction func menuButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
    }
    @IBAction func loginButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("LoginSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell
        let story = stories[indexPath.row]
        cell.configureWithStory(story)
        cell.delegate = self
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //sender must be indexPath
        performSegueWithIdentifier("WebSegue", sender: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // Mark:Storycell Delegate
    
    func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: AnyObject) {
        //sender must be cell
        performSegueWithIdentifier("CommentsSegue", sender: cell)
    }
    
    func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: AnyObject) {
        //确认是否登陆
        if let token = LocalStore.getToken(){
            let indexPath = tableView.indexPathForCell(cell)!
            let story = stories[indexPath.row]
            let storyId = story["id"].int!
            DNService.upvoteStoryWithId(storyId,token:token,response:{(successful) -> () in
                print(successful)
            })
            LocalStore.saveUpvotedStory(storyId)
            cell.configureWithStory(story)
        //若没有登录，弹出登录选项
        }else{
            performSegueWithIdentifier("LoginSegue", sender: self)
        }
    }
    
    
    // MARK: MenuViewControllerDelegate
    
    func menuViewControllerDidTouchTop(controller: MenuViewController) {
        view.showLoading()
        loadStories("", page: 1)
        navigationItem.title = "Top Stories"
        section = ""
    }
    
    func menuViewControllerDidTouchRecent(controller: MenuViewController) {
        view.showLoading()
        loadStories("recent", page: 1)
        navigationItem.title = "Recent Stories"
        section = "recent"
    }
    
    func menuViewControllerDidTouchLogout(controller: MenuViewController) {
        view.showLoading()
        loadStories(section, page: 1)
    }
    
    // MARK:Data Prepare before transition
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CommentsSegue" {
            let toView = segue.destinationViewController as! CommentsTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            toView.story = stories[indexPath.row]
        }
        
        if segue.identifier == "WebSegue"{
            let toView = segue.destinationViewController as! WebViewController
            let indexPath = sender as! NSIndexPath
            let url = stories[indexPath.row]["url"].string!
            toView.url = url
            
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
            
            toView.transitioningDelegate = transitionManager
        }
        
        //we can set the delegate to self.
        if segue.identifier == "MenuSegue" {
            let toView = segue.destinationViewController as! MenuViewController
            toView.delegate = self
        }
        
        if segue.identifier == "LoginSegue"{
            let toView = segue.destinationViewController as! LoginViewController
            toView.delegate = self
        }
    }
    
    // MARK:LoginViewControllerDelegate
    
    func loginViewControllerDidLogin(controller: LoginViewController) {
        loadStories(section, page:1)
        view.showLoading()
        

    }
    
    func menuViewControllerDidTouchLogin(controller: MenuViewController) {
        view.showLoading()
        loadStories(section, page:1)
        
    }
    
    
    
    
    

}
