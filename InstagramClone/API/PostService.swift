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
            
            let docRef = COLLETION_POSTS.addDocument(data: data, completion: completion)
            
            self.updateUserFeedAfterPost(postId: docRef.documentID)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void){
        COLLETION_POSTS.order(by: "timestamp", descending: true).getDocuments{ (snamshot, error) in
            guard let documents = snamshot?.documents else { return }
          
            let posts = documents.map({Post(postId: $0.documentID, dictonary: $0.data())})
            completion(posts)
        }
    }
    
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void){
        let query = COLLETION_POSTS.whereField("ownerUid", isEqualTo: uid)
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            var posts = documents.map({Post(postId: $0.documentID, dictonary: $0.data())})
            
            posts.sort { (post1, post2) -> Bool in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            
            completion(posts)        }
    }
    
    static func likePost(post: Post, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLETION_POSTS.document(post.postId).updateData(["likes": post.likes + 1])
        
        COLLETION_POSTS.document(post.postId).collection("post-likes").document(uid).setData([:]){ _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).setData([:], completion: completion)
        }
    }
    
    static func unlikePost(post: Post, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard post.likes > 0 else { return }
        
        COLLETION_POSTS.document(post.postId).updateData(["likes": post.likes - 1])
        
        COLLETION_POSTS.document(post.postId).collection("post-likes").document(uid).delete() {_ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).delete(completion: completion)
        }
    }
    
    static func checkIfUserLikedPost(post: Post, completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }

        COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).getDocument { (snapshot, _) in
            guard let didLike = snapshot?.exists else { return }
            completion(didLike)
        }
    }
    
    static func fetchPost(withPostId postId: String, completion: @escaping(Post) -> Void){
        COLLETION_POSTS.document(postId).getDocument { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            guard let data = snapshot.data() else { return }
            let post = Post(postId: snapshot.documentID, dictonary: data)
            completion(post)
        }
    }
    
    static func fetchFeedPosts(completion: @escaping([Post]) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var posts = [Post]()
        COLLECTION_USERS.document(uid).collection("user-feed").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({document in
                fetchPost(withPostId: document.documentID) { post in
                    posts.append(post)
                    completion(posts)
                }
            })
        }
    }
    
    static func updateUserFeedAfterFollowing(user: User, didFollow: Bool){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query = COLLETION_POSTS.whereField("ownerUid", isEqualTo: user.uid)
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let docIDs = documents.map({ $0.documentID })
            docIDs.forEach{id in
                
                if didFollow {
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).setData([:])
                }else {
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).delete()
                }
            }
        }
        
    }
    
    private static func updateUserFeedAfterPost(postId: String){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLETION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, _) in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach {document in
                COLLECTION_USERS.document(document.documentID).collection("user-feed").document(postId).setData([:])
            }
            
            COLLECTION_USERS.document(uid).collection("user-feed").document(postId).setData([:])
            
        }
    }
    
}
