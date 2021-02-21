//
//  CommentServerice.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-20.
//

import Firebase

struct CommentServerice {
    
    static func uploadComment(comment: String, postID: String, user: User, completion: @escaping(FirestoreCompletion)){
        let data : [String: Any] = ["uid": user.uid, "comment": comment, "timestamp": Timestamp(date: Date()), "username": user.username, "profileImageUrl": user.profileImageUrl]
        COLLETION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
    }
    
    static func fetchComments(){
        
    }
}
