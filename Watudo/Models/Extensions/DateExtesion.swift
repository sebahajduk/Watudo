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
}
