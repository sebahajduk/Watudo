////
////  User.swift
////  Watudo
////
////  Created by Sebastian Hajduk on 04/12/2022.
////
//
import UIKit

struct LocalUser {
    var name: String = ""
    let email = ""

    var activities: [Activity] = []
    var categories: [Category] = []

    init(name: String, activities: [Activity], categories: [Category]) {
        self.name = name
        self.activities = activities
        self.categories = categories
    }
}
