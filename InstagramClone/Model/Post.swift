//
//  Post.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-18.
//

import Foundation
import Firebase

struct Post {
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timesTamp: Timestamp
    let postId: String
    let ownerImageUrl: String
    let ownerUsername: String
    
    init(postId: String, dictonary: [String: Any]) {
        self.caption = dictonary["caption"] as? String ?? ""
        self.likes = dictonary["likes"] as? Int ?? 0
        self.imageUrl = dictonary["imageUrl"] as? String ?? ""
        self.ownerUid = dictonary["ownerUid"] as? String ?? ""
        self.timesTamp = dictonary["timesTamp"] as? Timestamp ?? Timestamp(date: Date())
        self.postId = dictonary["postId"] as? String ?? ""
        self.ownerImageUrl = dictonary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictonary["ownerUsername"] as? String ?? ""
    }
    
}
