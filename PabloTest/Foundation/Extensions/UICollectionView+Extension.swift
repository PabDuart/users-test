//
//  UICollectionView+Extension.swift
//  PabloTest
//
//  Created by Pablo Duarte on 13/12/21.
//

import UIKit

extension UICollectionView {
        func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width * 0.9, height: frame.size.height))
        messageLabel.text = message
        messageLabel.textColor = AppSettings.Color.darkGreen
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        messageLabel.sizeToFit()
        backgroundView = messageLabel;
    }
    
    func restore() {
        backgroundView = nil
    }
}
