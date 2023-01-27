//
//  Quote.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 26/01/2023.
//

import Foundation

class Quotes: Codable {
    let quotes: [Quote]
}

class Quote: Codable {
    let q: String
    let a: String
    let h: String
}
