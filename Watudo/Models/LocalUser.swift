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
    
    var activities: [Activity] = []
    var categories: [Category] = []
    
    init(activities: [Activity], categories: [Category]) {
        self.activities = activities
        self.categories = categories
    }
}
