//
//  File.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 10/02/2023.
//

import UIKit

extension Date {
    
    /// Converting date to String
    /// - Returns: Date in format of year-month-day as a String
    func dateToStringYMD() -> String {
        let date = self
        var formatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }
        
        return formatter.string(from: date)
    }
    
    /// Converting date to String
    /// - Returns: Date in format of hours:minutes:seconds as a String
    func dateToStringHMS() -> String {
        let date = self
        var formatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            return formatter
        }
        
        return formatter.string(from: date)
    }
    
    func getWeekdayString(for date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let day = formatter.date(from: date) else { return "Invalid data format."}
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.dateFormat = "EEE"
        let weekday = dateFormatter.string(from: day)
        return weekday
    }
}
