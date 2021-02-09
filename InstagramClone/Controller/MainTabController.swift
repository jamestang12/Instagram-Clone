//
//  MainTabController.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-08.
//

import UIKit


class MainTabController: UITabBarController{
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    func configureViewControllers(){
        view.backgroundColor = .white
        
        let feed = FeedController()
        
        let search = SearchController()
        
        let imageSelector = ImageSelectorController()
        
        let notification = NotificationController()
        
        let profile = ProfileController()
        
        viewControllers = [feed, search, imageSelector, notification, profile]
    }
    

}
