//
//  User.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-14.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    init(dictonary: [String: Any]) {
        self.email = dictonary["email"] as? String ?? ""
        self.fullname = dictonary["fullname"] as? String ?? ""
        self.profileImageUrl = dictonary["profileImageUrl"] as? String ?? ""
        self.username = dictonary["username"] as? String ?? ""
        self.uid = dictonary["uid"] as? String ?? ""

    }
}
