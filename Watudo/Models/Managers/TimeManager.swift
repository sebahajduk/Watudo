//
//  TimeManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 07/02/2023.
//

import UIKit

class TimeManager {
    
    static let shared = TimeManager()
    
    var isTimerActive: Bool = false
    
    func startTimer(for activity: Activity) {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            activity.timeSpent += 1
        }
        
        RunLoop.main.add(timer, forMode: .common)
        isTimerActive = true
    }
    
}
