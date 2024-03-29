//
//  Category.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 04/01/2023.
//

import UIKit

struct Category: Equatable, Codable, Addable {
    let id = UUID()
    var name: String = ""
    var colorHEX: String = ""

    init(name: String, colorHEX: String = WColors.green!.hexStringFromColor()) {
        self.name = name
        self.colorHEX = colorHEX
    }

    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name
    }

    private enum CodingKeys: CodingKey {
        case id, name, colorHEX
    }
}
