//
//  Category.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 04/01/2023.
//

import UIKit

struct Category: Equatable {
    let id = UUID()
    var name: String
    var color: UIColor
    var timeSpent: Double
    
    init(name: String, timeSpent: Double, color: UIColor = WColors.foreground!) {
        self.name = name
        self.color = color
        self.timeSpent = timeSpent
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
}
