//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by James Tang on 2021-02-13.
//

import UIKit

class ProfileHeader: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}
