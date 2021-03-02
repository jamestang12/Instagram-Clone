//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by James Tang on 2021-03-02.
//

import UIKit

struct NotificationViewModel{
    
    private let notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? {
        return URL(string: notification.postImaheUrl ?? "")
    }
    
    var profileImage: URL? {
        return URL(string: notification.userProfileImageUrl)
    }
    
}
