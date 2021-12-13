//
//  DesignableView.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

import UIKit

class DesignableView: UIView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
        
    @IBInspectable var borderColorNew: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
        
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColorNew: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }
      
    @IBInspectable var shadowX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
      
    @IBInspectable var shadowY: CGFloat = -3 {
        didSet {
            setNeedsLayout()
        }
    }
      
    @IBInspectable var shadowBlur: CGFloat = 3 {
        didSet {
            setNeedsLayout()
        }
    }
      
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
        
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius == -1 ? frame.size.height / 2 : cornerRadius
        layer.masksToBounds = masksToBounds
        layer.shadowColor = shadowColorNew.cgColor
        layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
        layer.shadowRadius = shadowBlur
        layer.shadowOpacity = shadowOpacity
    }
}
