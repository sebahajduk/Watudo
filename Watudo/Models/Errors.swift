//
//  Errors.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 08/03/2023.
//

import Foundation

enum WError: Error {
    case categoryIsNotEmpty,
         emptyEmailPasswordReset,
         categoryNameTaken
}

extension WError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyEmailPasswordReset:
            return NSLocalizedString("Please write an email before reseting password.",
                                     comment: "Email is empty")
        case .categoryIsNotEmpty:
            return NSLocalizedString("Category is not empty, please delete all activities before deleting category.",
                                     comment: "Category is not empty")
        case .categoryNameTaken:
            return NSLocalizedString("Category name is already taken. Please choose another one",
                                     comment: "Category already exists")
        }
    }
}
