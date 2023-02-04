////
////  User.swift
////  Watudo
////
////  Created by Sebastian Hajduk on 04/12/2022.
////
//
import UIKit

class LocalUser {
    var name: String = ""
    let email = ""
    
    var categories: [Category] = []
    let activities: [Activity] = []
    
    init() {
        let codingCategory = Category(name: "Coding")
        let databaseCategory = Category(name: "Database")
        
        codingCategory.activities.append(Activity(name: "Watudo"))
        databaseCategory.activities.append(Activity(name: "Firestore"))
        
        categories.append(codingCategory)
        categories.append(databaseCategory)
    }
}
