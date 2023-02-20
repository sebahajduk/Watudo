//
//  Day.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 09/01/2023.
//

import Foundation

class Day: Decodable {
    var date: String = ""
    var activities: [Activity] = []
}
