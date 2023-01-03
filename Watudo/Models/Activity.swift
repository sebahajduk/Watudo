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
    
    init(name: String, dailyGoal: Double? = nil) {
        self.name = name
        self.dailyGoal = dailyGoal
    }
}
