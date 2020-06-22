//
//  PostContent.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 12.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation

struct PostContent: Decodable, Hashable {
    var avatarUUID: String?
    var username: String
    var nickname: String?
    var desc: String
    var postImageUUIDs: [String]?
    var sharedOn: String
    var likeCount: Int
}
