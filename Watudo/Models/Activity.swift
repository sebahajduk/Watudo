//
//  Activity.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/01/2023.
//

import Foundation

class Activity: NSCoder, Codable, Addable {

    weak var delegate: ActivityDelegate?

    var id = UUID()
    var name: String
    var dailyGoal: Double?
    var category: Category

    var timeSpent: Double = 0 {
        didSet {
            delegate?.activityDidChange()
        }
    }

    var startDate: Date?
    var endDate: Date?

    var isPaid: Bool
    var moneyPerHour: Double = 0
    var timer: Timer!

    init(name: String, category: Category, dailyGoal: Double? = nil, isPaid: Bool, moneyPerHour: Double) {
        self.name = name
        self.dailyGoal = dailyGoal
        self.category = category
        self.isPaid = isPaid
        self.moneyPerHour = moneyPerHour
    }

    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }

    static func += (lhs: inout Activity, rhs: Activity) {
        lhs.timeSpent += rhs.timeSpent
    }

    private enum CodingKeys: CodingKey {
        case id, name, category, dailyGoal, timeSpent, isPaid, moneyPerHour
    }

    func startWork() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
            self?.timeSpent = Date().timeIntervalSince(self?.startDate! ?? Date())
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
