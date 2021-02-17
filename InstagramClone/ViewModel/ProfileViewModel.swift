//
//  ProfileViewModel.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-14.
//

import UIKit

struct ProfileViewModel{
    let user: User
    
    var fullname: String{
        return user.fullname
    }
    
    var profileImageUrl: URL?{
        return URL(string: user.profileImageUrl)
    }
    
    var followButtonText: String{
        if user.isCurrentUser{
            return "Edit Profile"
        }
        
        return user.isFollwed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor{
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor{
        return user.isCurrentUser ? .black : .white
    }
    
    init(user: User){
        self.user = user
    }
}
