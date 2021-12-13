//
//  PostTableViewCell.swift
//  PabloTest
//
//  Created by Pablo Duarte on 12/12/21.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    func configureCell(with posts: Post) {
        titleLabel.text = posts.title
        bodyLabel.text = posts.body
    }
}
