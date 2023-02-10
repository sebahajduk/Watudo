//
//  ActivityManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 10/02/2023.
//

import Foundation

class ActivityManager: TimeManagment {
    var timer: Timer = Timer()
    var isTimerActive: Bool = false
    
    func startTimer(for activity: Activity) {
        
    }
    
    func stopTimer(for activity: Activity) {
        timer.invalidate()
    }
}
