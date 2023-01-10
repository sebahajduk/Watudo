//
//  ReportsCalendarHeader.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 10/01/2023.
//

import Foundation
import JTAppleCalendar

class ReportsCalendarHeader: JTACMonthReusableView {
    static let reuseID = "ReportsCalendarHeader"
    
    var monthTitle = UILabel()
    
    private func configure() {
        addSubview(monthTitle)
        monthTitle.textAlignment = .center
        monthTitle.translatesAutoresizingMaskIntoConstraints = false
        monthTitle.textColor = WColors.foreground
        monthTitle.font = UIFont(name: "Panton-BlackCaps", size: 20)
        
        NSLayoutConstraint.activate([
            monthTitle.topAnchor.constraint(equalTo: topAnchor),
            monthTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            monthTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            monthTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func set(month: String) {
        configure()
        monthTitle.text = month
    }
}
