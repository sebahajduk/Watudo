//
//  WAnimations.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 14/12/2022.
//

import UIKit

struct WAnimations {
    
    static func buttonTapAnimation(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.1, delay: 0) {
            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        } completion: { (_) in
            UIButton.animate(withDuration: 0.1, delay: 0) {
                sender.transform = CGAffineTransform.identity
            }
        }
    }
    
}
