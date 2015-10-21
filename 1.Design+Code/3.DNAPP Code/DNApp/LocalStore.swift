//
//  LocalStore.swift
//  DNApp
//
//  Created by KingMartin on 15/10/21.
//  Copyright © 2015年 Meng To. All rights reserved.
//

import UIKit

struct LocalStore {
    static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    static func saveToken(token:String){
        userDefaults.setObject(token, forKey: "tokenKey")
    }
    
    static func getToken()->String?{
        return userDefaults.stringForKey("tokenKey")
    }
    
    static func deleteToken(){
        userDefaults.removeObjectForKey("tokenKey")
    }
    
    
    //点赞的Story和评论
    static func saveUpvotedStory(storyId: Int) {
        appendId(storyId, toKey: "upvotedStoriesKey")
    }
    
    static func saveUpvotedComment(commentId: Int) {
        appendId(commentId, toKey: "upvotedCommentsKey")
    }
    
    //check if the story or comment is Upvoted
    static func isStoryUpvoted(storyId: Int) -> Bool {
        return arrayForKey("upvotedStoriesKey", containsId: storyId)
    }
    
    static func isCommentUpvoted(commentId: Int) -> Bool {
        return arrayForKey("upvotedCommentsKey", containsId: commentId)
    }
    
    // MARK: Helper
    
    private static func arrayForKey(key: String, containsId id: Int) -> Bool {
        let elements = userDefaults.arrayForKey(key) as? [Int] ?? []
        return elements.contains(id)
    }
    
    private static func appendId(id: Int, toKey key: String) {
        let elements = userDefaults.arrayForKey(key) as? [Int] ?? []
        if !elements.contains(id) {
            userDefaults.setObject(elements + [id], forKey: key)
        }
    }
    
    
}