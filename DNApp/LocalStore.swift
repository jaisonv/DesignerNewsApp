//
//  LocalStore.swift
//  DNApp
//
//  Created by Jaison Vieira on 7/1/15.
//  Copyright (c) 2015 Jaison Vieira. All rights reserved.
//

import UIKit

struct LocalStore {
    static let userDefaults = NSUserDefaults.standardUserDefaults()
    static let tokenKey = "tokenKey"
    static let upvoteStoriesKey = "upvoteStoriesKey"
    static let upvoteCommentKey = "upvoteCommentKey"

    
    static func saveToken(token: String) {
        userDefaults.setObject(token, forKey: tokenKey)
    }
    
    static func getToken() -> String? {
        return userDefaults.stringForKey(tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObjectForKey(tokenKey)
    }
    
    static func saveUpvotedStory(storyId: Int) {
        appendId(storyId, tokey: upvoteStoriesKey)
    }
    
    static func saveUpvotedComment(commentId: Int) {
        appendId(commentId, tokey: upvoteCommentKey)
    }
    
    static func isStoryUpvoted(storyId: Int) -> Bool {
        return arrayForKey(upvoteStoriesKey, containsId: storyId)
    }
    
    static func isCommentUpvoted(commentId: Int) -> Bool {
        return arrayForKey(upvoteCommentKey, containsId: commentId)
    }
    
    // MARK: Helper
    
    private static func arrayForKey(key: String, containsId id: Int) -> Bool {
        let elements = userDefaults.arrayForKey(key) as? [Int] ?? []
        return contains(elements, id)
    }
    
    private static func appendId(id: Int, tokey key: String) {
        let elements = userDefaults.arrayForKey(key) as? [Int] ?? []
        if !contains(elements, id) {
            userDefaults.setObject(elements + [id], forKey: key)
        }
    }
}
