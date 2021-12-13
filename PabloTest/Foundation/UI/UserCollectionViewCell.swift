//
//  UserCollectionViewCell.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

import UIKit

protocol UserCollectionViewCellDelegate: AnyObject {
    func userCollectionView(_ userCollectionView: UserCollectionViewCell, didTapPostsButtonWith user: User)
}

final class UserCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var mailLabel: UILabel!
    @IBOutlet private weak var postsButton: UIButton!
    
    // MARK: Vars
    weak var delegate: UserCollectionViewCellDelegate?
    private var user: User?
    
    // MARK: Functions
    func configureCell(with user: User, and delegate: UserCollectionViewCellDelegate) {
        self.user = user
        self.delegate = delegate
        nameLabel.text = user.name
        phoneLabel.text = user.phone
        mailLabel.text = user.email
    }
    
    // MARK: Actions
    @IBAction func didTapPostsButton(_ sender: UIButton) {
        if let user = user {
            delegate?.userCollectionView(self, didTapPostsButtonWith: user)
        }
    }
}
