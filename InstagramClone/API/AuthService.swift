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
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void){
        print("DEBUG: Credentials are \(credentials)")
        
        ImageUploader.uploadImage(image: credentials.profileImage) { (imageUrl) in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("DEBUG: Failed to register user\(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credentials.email, "fullname": credentials.fullname, "profileImageUrl": imageUrl, "uid": uid, "username": credentials.username]
                
                Firestore.firestore().collection("users").document(uid).setData(data,  completion:  completion)
            }
        }
    }
    
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
