//
//  UserService.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-14.
//

import Firebase


struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument{snapshot, error in
            guard let dictonary = snapshot?.data() else { return }
            
            let user = User(dictonary: dictonary)
            completion(user)
        }
    }
}
