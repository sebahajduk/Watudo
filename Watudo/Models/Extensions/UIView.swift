//
//  UIButtonExtension.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 13/12/2022.
//

import UIKit

extension UIView {
    
    public func addShadowToView(shadowColor: UIColor, offset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float, cornerRadius: CGFloat) {
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowOffset = offset
            self.layer.shadowRadius = shadowRadius
            self.layer.cornerRadius = cornerRadius
    }
    
    public func addCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
}
