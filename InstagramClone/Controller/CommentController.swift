//
//  CommentController.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-20.
//

import UIKit

private let reuseIdentifer = "CommentCell"

class CommentController: UICollectionViewController{
    
    // MARK: - Properties
    
    
    // MARKL - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    // MARK: - Helpers
    func configureCollectionView(){
        navigationItem.title = "Comments"
        collectionView.backgroundColor = .white

        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifer)
    }
}




// MARK: - UICollectionViewDataSource

extension CommentController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}
