//
//  Errors.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 08/03/2023.
//

import Foundation

enum WError: Error {
    case categoryIsNotEmpty
}

extension WError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .categoryIsNotEmpty:
            return NSLocalizedString("Category is not empty, please delete all activities before deleting category.", comment: "Category is not empty")
        }
    }
}
