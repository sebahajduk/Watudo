//
//  Category.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 04/01/2023.
//

import UIKit

class Category: Equatable {
    let id = UUID()
    var name: String
    
    var color: UIColor
    
    var activities: [Activity] = []
    var timeSpend: Double = 5
    
    init(name: String, color: UIColor = WColors.foreground!) {
        self.name = name
        self.color = color
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
}

