//
//  PostDetailsCollectionViewCell.swift
//  PabloTest
//
//  Created by Pablo Duarte on 11/12/21.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
   
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func configureCell(with posts: Post) {
        titleLabel.text = posts.title
        bodyLabel.text = posts.body
    }
}
