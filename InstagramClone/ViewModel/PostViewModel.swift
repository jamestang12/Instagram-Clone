//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-19.
//

import UIKit

struct PostViewModel {
    
   // let post: Post
    
    var post: Post
    
    
    var userProfileImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    var likeButtonTintColor: UIColor{
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
    }
    
    var username: String {
        return post.ownerUsername
    }
    
    var imageUrl: URL?{
        return URL(string: post.imageUrl)
    }
    
    var caption: String{
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    var likesLabelText: String{
        if post.likes != 1 {
            return "\(post.likes) likes"
        }else {
            return "\(post.likes) like"
        }
    }
    
//    var timestampString: String?{
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
//        formatter.maximumUnitCount = 1
//        formatter.unitsStyle = .full
//        return formatter.string(from: post.timesTamp.dateValue(), to: Date())
//    }
    
    var timestampString: String?{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: post.timestamp.dateValue(), to: Date())
    }
    
    init(post: Post) {
        self.post = post
    }
}
