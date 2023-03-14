//
//  WVisualEffect.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 10/01/2023.
//

import UIKit

class WVisualEffectView: UIVisualEffectView {

    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)

        backgroundColor = WColors.foreground?.withAlphaComponent(0.05)
    }

    convenience init(effect: UIVisualEffect? = nil, cornerRadius: CGFloat) {
        self.init(effect: effect)
        self.addCornerRadius(radius: cornerRadius)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
