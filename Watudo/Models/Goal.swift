//
//  Goal.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 02/01/2023.
//

import UIKit

class Goal {
    let id = UUID()
    let name: String
    let image: UIImageView
    
    init(name: String, image: UIImageView) {
        self.name = name
        self.image = image
    }
}
