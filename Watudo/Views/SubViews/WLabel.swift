//
//  WLabel.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 24/01/2023.
//

import UIKit

enum WLabelWeight {
    case light, black
}

class WLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, textAlignment: NSTextAlignment = .left, size: CGFloat, weight: WLabelWeight, color: UIColor = .label) {
        self.init(frame: .zero)
        
        self.text = text
        self.textAlignment = textAlignment
        self.textColor = color
        
        switch weight {
        case .light:
            font = UIFont(name: "Panton-LightCaps", size: size)
        case .black:
            font = UIFont(name: "Panton-BlackCaps", size: size)
        }
    }
    
}
