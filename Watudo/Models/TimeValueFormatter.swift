//
//  TimeValueFormatter.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 06/03/2023.
//

import Foundation
import Charts

class TimeValueFormatter: AxisValueFormatter {
    private let timeFormatter = DateComponentsFormatter()

    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        timeFormatter.allowedUnits = [.hour, .minute, .second]
        return timeFormatter.string(from: value)!
    }
}
