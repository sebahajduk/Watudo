//
//  Activity.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/01/2023.
//

import Foundation

class Activity: NSObject, Codable {
    
    weak var delegate: ActivityDelegate? = nil
    
    var id = UUID()
    var name: String
    var dailyGoal: Double? = nil
    var timeSpent: Double = 0 {
        didSet {
            delegate?.activityDidChange()
        }
    }
    
    var startDate: Date?
    var endDate: Date?
    
    var isPaid: Bool = false
    var moneyPerHour: Double = 0
    var timer: Timer!
    
    #warning("Remove 'timeSpent' from init.")
    init(name: String, dailyGoal: Double? = nil, isPaid: Bool = false, moneyPerHour: Double = 0, timeSpent: Double = 0) {
        self.name = name
        self.dailyGoal = dailyGoal
        self.timeSpent = timeSpent
    }
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
    
    private enum CodingKeys: CodingKey {
        case id, name, dailyGoal, timeSpent, isPaid, moneyPerHour
    }
    
    func startWork() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            self.timeSpent = Date().timeIntervalSince(self.startDate!)
        })
        
        RunLoop.main.add(timer, forMode: .common)
    }
    
    func finishWork() -> Activity {
        timer.invalidate()
        endDate = Date()
        
        return self
    }
    
    private func resetActivity() {
        timeSpent = 0
    }
}

protocol ActivityDelegate: AnyObject {
    func activityDidChange()
}
