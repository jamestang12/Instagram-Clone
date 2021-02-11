//
//  AuthService.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-10.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct  AuthService {
    static func registerUser(withCredential credentials: AuthCredentials){
        print("DEBUG: Credentials are \(credentials)")
    }
}
