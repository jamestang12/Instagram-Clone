//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-19.
//

import Foundation

struct PostViewModel {
    
    private let post: Post
    
    var imageUrl: URL?{
        return URL(string: post.imageUrl)
    }
    
    var caption: String{
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    init(post: Post) {
        self.post = post
    }
}
