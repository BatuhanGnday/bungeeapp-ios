//
//  FeedResult.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 12.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation

class FeedResult {
    var posts: [PostContent]?
    
    internal init (posts: [PostContent]) {
        self.posts = posts
    }
    
    func getPosts() -> [PostContent] {
        return self.posts!
    }
}
