//
//  ReportsCalendarCell.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 10/01/2023.
//

import Foundation
import JTAppleCalendar

class ReportsCalendarCell: JTACDayCell {
    
    static let reuseID = "ReportsCalendarCell"
    
    var dateLabel = UILabel()
    
    func set(forDate: String) {
        configure()
        dateLabel.text = forDate
    }
    
    func setColor(forAlpha: Double) {
        dateLabel.textColor = WColors.purple?.withAlphaComponent(forAlpha)
    }
    
    func configure() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 40),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
