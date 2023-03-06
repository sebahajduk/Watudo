//
//  WButton.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 07/12/2022.
//

import UIKit

enum ButtonRole {
    case primary, secondary
}

class WButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            updateButtonUI()
        }
    }
    
    private var buttonRole: ButtonRole = .primary
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(title: String, role: ButtonRole) {
        self.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        switch role {
        case .primary:
            setTitleColor(WColors.background, for: .normal)
            if !self.isEnabled {
                backgroundColor = WColors.purple!.withAlphaComponent(0.3)
            } else {
                backgroundColor = WColors.purple
            }
        case .secondary:
            setTitleColor(WColors.purple, for: .normal)
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = WColors.purple?.cgColor
        }
    }
    
    convenience init(image: UIImage, role: ButtonRole) {
        self.init(frame: .zero)
        
        setImage(image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        
        switch role {
        case .primary:
            tintColor = WColors.background
            backgroundColor = WColors.purple
        case .secondary:
            tintColor = WColors.purple
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = WColors.purple?.cgColor
        }
    }
    
    func updateButtonUI() {
        if !isEnabled && buttonRole == .primary {
            backgroundColor = WColors.purple!.withAlphaComponent(0.3)
        } else if isEnabled && buttonRole == .primary {
            backgroundColor = WColors.purple
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
