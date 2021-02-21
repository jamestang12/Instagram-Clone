//
//  UserService.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-14.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void


struct UserService {
    static func fetchUser(whithUid uid: String ,completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument{snapshot, error in
            guard let dictonary = snapshot?.data() else { return }
            
            let user = User(dictonary: dictonary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void){
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({User(dictonary: $0.data())})
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        COLLETION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { (error) in
            COLLETION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLETION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { (error) in
            COLLETION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    static func checkIfUserIsFolloed(uid: String, completion: @escaping(Bool) -> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLETION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { (snapshot, error) in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
        
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void){
        COLLETION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, _) in
            let followers = snapshot?.documents.count ?? 0
            COLLETION_FOLLOWING.document(uid).collection("user-following").getDocuments { (snapshot, _) in
                let following = snapshot?.documents.count ?? 0
                
                COLLETION_POSTS.whereField("ownerUid", isEqualTo:  uid).getDocuments { (snapshot, _) in
                    let posts = snapshot?.documents.count ?? 0
                    completion(UserStats(followers: followers, following: following, posts: posts))

                }
            }
        }
    }
    
}
