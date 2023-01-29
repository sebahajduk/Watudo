//
//  Activity.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/01/2023.
//

import Foundation

class Activity: Equatable {
    var id = UUID()
    var name: String
    var dailyGoal: Double? = nil
    var timeSpent: Double = 0
    var isPaid: Bool = false
    var moneyPerHour: Double = 0
    
    var category: Category?
    
    #warning("Remove 'timeSpent' from init.")
    init(name: String, dailyGoal: Double? = nil, isPaid: Bool = false, moneyPerHour: Double = 0, timeSpent: Double = 0, category: Category) {
        self.name = name
        self.dailyGoal = dailyGoal
        self.timeSpent = timeSpent
        self.category = category
    }
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
}
