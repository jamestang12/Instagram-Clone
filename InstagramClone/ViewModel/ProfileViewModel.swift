//
//  ProfileViewModel.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-14.
//

import Foundation

struct ProfileViewModel{
    let user: User
    
    var fullname: String{
        return user.fullname
    }
    
    var profileImageUrl: URL?{
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User){
        self.user = user
    }
}
