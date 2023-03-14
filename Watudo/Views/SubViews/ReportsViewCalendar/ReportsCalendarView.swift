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

    let visualEffect = WVisualEffectView(cornerRadius: 30)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        addSubviews([visualEffect, myCalendar])

        myCalendar.backgroundColor = .clear
        myCalendar.addCornerRadius(radius: 30)
        myCalendar.minimumLineSpacing = 0
        myCalendar.scrollDirection = .horizontal
        myCalendar.isPagingEnabled = true
        myCalendar.showsHorizontalScrollIndicator = false

        myCalendar.register(ReportsCalendarHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: ReportsCalendarHeader.reuseID)

        myCalendar.register(ReportsCalendarCell.self,
                            forCellWithReuseIdentifier: ReportsCalendarCell.reuseID)

        myCalendar.allowsRangedSelection = true
        myCalendar.allowsSelection = true
        myCalendar.allowsMultipleSelection = true

        myCalendar.scrollToHeaderForDate(Date())

        NSLayoutConstraint.activate([
            visualEffect.topAnchor.constraint(equalTo: topAnchor),
            visualEffect.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffect.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffect.bottomAnchor.constraint(equalTo: bottomAnchor),

            myCalendar.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 5),
            myCalendar.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 5),
            myCalendar.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -5),
            myCalendar.bottomAnchor.constraint(equalTo: visualEffect.bottomAnchor, constant: -10)
        ])
    }
}
