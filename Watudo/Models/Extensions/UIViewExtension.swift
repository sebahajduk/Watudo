////
////  UIViewExtension.swift
////  Watudo
////
////  Created by Sebastian Hajduk on 03/12/2022.
////

import UIKit

extension UIView {
    
    // Add multiple views at one line of code.
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func addShadowToView(shadowColor: UIColor, offset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float, cornerRadius: CGFloat) {
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowOffset = offset
            self.layer.shadowRadius = shadowRadius
            self.layer.cornerRadius = cornerRadius
    }
    
    func addCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}

