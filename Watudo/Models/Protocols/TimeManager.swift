//
//  TimeManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 07/02/2023.
//

import UIKit

protocol TimeManagment {
    var isTimerActive: Bool { get set }
    var timer: Timer { get set }
    
    func startTimer(for activity: Activity)
    func stopTimer(for activity: Activity)
}
