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
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = CommentInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    // MARKL - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override var inputAccessoryView: UIView?{
        get { return commentInputView }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Helpers
    func configureCollectionView(){
        navigationItem.title = "Comments"
        collectionView.backgroundColor = .white

        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
}




// MARK: - UICollectionViewDataSource

extension CommentController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}

// MARK: - CommentInputAccesoryViewDelegate

extension CommentController: CommentInputAccesoryViewDelegate{
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        inputView.clearCommentTextView()
    }
}
