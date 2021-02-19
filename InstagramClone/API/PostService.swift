//
//  PostService.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-18.
//

import UIKit
import Firebase

struct  PostService {
    
    static func uploadPost(caption: String, image: UIImage, user: User,completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { (imageUrl) in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": uid,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username] as [String: Any]
            COLLETION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void){
        COLLETION_POSTS.order(by: "timestamp", descending: true).getDocuments{ (snamshot, error) in
            guard let documents = snamshot?.documents else { return }
            
            let posts = documents.map({Post(postId: $0.documentID, dictonary: $0.data())})
            completion(posts)
        }
    }
}
