//
//  ReportsViewCalendar.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 10/01/2023.
//

import UIKit
import JTAppleCalendar

class ReportsCalendarView: UIView {
    let myCalendar = JTACMonthView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(myCalendar)
        myCalendar.translatesAutoresizingMaskIntoConstraints = false
        myCalendar.backgroundColor = WColors.foreground?.withAlphaComponent(0.05)
        myCalendar.addCornerRadius(radius: 30)
        myCalendar.minimumLineSpacing = 0
        myCalendar.scrollDirection = .horizontal
        myCalendar.isPagingEnabled = true
        myCalendar.showsHorizontalScrollIndicator = false
        
        myCalendar.register(ReportsCalendarHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReportsCalendarHeader.reuseID)
        myCalendar.register(ReportsCalendarCell.self, forCellWithReuseIdentifier: ReportsCalendarCell.reuseID)

        myCalendar.allowsRangedSelection = true
        myCalendar.allowsSelection = true
        myCalendar.allowsMultipleSelection = true
        
        myCalendar.scrollToHeaderForDate(Date())
        
        NSLayoutConstraint.activate([
            myCalendar.topAnchor.constraint(equalTo: topAnchor),
            myCalendar.leadingAnchor.constraint(equalTo: leadingAnchor),
            myCalendar.trailingAnchor.constraint(equalTo: trailingAnchor),
            myCalendar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

