//
//  NotificationController.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-08.
//

import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationController: UITableViewController {
    
    // MARK: - Properties
    
    private var notifications = [Notification](){
        didSet{ tableView.reloadData() }
    }
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
            configureTableView()
            fetchNotifications()

    }
    
    // MARK: - API
    func fetchNotifications(){
        NotificationService.fetchNotifications { (notifications) in
            self.notifications = notifications
            self.checkIfUserIsFollowed()
        }
    }
    
    func checkIfUserIsFollowed(){
        notifications.forEach { (notification) in
            guard notification.type == .follow else { return }
            UserService.checkIfUserIsFolloed(uid: notification.uid) { (isFollowed) in
                if let index = self.notifications.firstIndex(where: {$0.id == notification.id}){
                    self.notifications[index].userIsFollowed = isFollowed
                }
            }
        }
    }
    
    // MARK: - Helpers
    func configureTableView(){
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }

}

// MARK: - UITableViewDataSource

extension NotificationController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
}


// MARK: - UITableViewDelegate

extension NotificationController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - NotificationCellDelegate

extension NotificationController: NotificationCellDelegate {
    func cell(_ cell: NotificationCell, wantsToFollow uid: String) {
        print("DEBUG: Follow user here.....")
    }
    
    func cell(_ CELL: NotificationCell, wantsToUnfollow uid: String) {
        print("DEBUG: Unfollow user here")
    }
    
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String) {
        print("DEBUG: Show post here")
    }
    
    
}
