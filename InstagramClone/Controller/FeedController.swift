//
//  FeedController.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-08.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
class FeedController: UICollectionViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Action
    @objc func habdleLogout(){
        do{
            try Auth.auth().signOut()
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }catch{
            print("DEBUG: Failed to sign out")
        }
    }
    
    // MARK: - Helpers
    func configureUI(){
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(habdleLogout))
        
        navigationItem.title = "Feed"
    }
    
}

// MARK: - UICollectionViewDataSource
extension FeedController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        return cell
    }
}

// MARKL - UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        return CGSize(width: width, height: height)
    }
}
