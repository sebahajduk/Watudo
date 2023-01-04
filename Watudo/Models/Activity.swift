//
//  Activity.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/01/2023.
//

import Foundation

class Activity {
    var name: String
    var dailyGoal: Double? = nil
    var timeSpent: Double = 0
    var isPaid: Bool = false
    var moneyPerHour: Double = 0
    
    var category: Category?
    
    init(name: String, dailyGoal: Double? = nil, isPaid: Bool = false, moneyPerHour: Double = 0) {
        self.name = name
        self.dailyGoal = dailyGoal
    }
}
