//
//  Category.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 04/01/2023.
//

import Foundation

struct Category {
    let id = UUID()
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
