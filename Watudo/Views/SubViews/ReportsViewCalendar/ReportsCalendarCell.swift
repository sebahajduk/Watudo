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
    private let circle = WVisualEffectView()
    private let dateLabel = UILabel()
    private var isLightMode: Bool!
    
    let dotView = WVisualEffectView(cornerRadius: 3)

    var cellSelected: Bool = false {
        didSet {
            setColor(forAlpha: 1.0)
            selectionChanged()
        }
    }
    
    var isToday: Bool = false {
        didSet {
            markTodayCell()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isSelected = false
    }
    
    func set(forDate: String) {
        configure()
        dateLabel.text = forDate
        
        isLightMode = traitCollection.userInterfaceStyle == .light ? true : false
    }
    
    func setColor(forAlpha: Double = 1.0) {
        if cellSelected {
            self.dateLabel.textColor = .white.withAlphaComponent(forAlpha)
            self.circle.backgroundColor = WColors.purple?.withAlphaComponent(forAlpha)
        } else {
            self.dateLabel.textColor = WColors.foreground?.withAlphaComponent(forAlpha)
            self.circle.backgroundColor = WColors.purple?.withAlphaComponent(0.05)
        }
    }
    
    private func markTodayCell() {
        if isToday {
            circle.backgroundColor = WColors.green
            dateLabel.textColor = .white
        }
    }
    
    private func selectionChanged() {
        if cellSelected {
            if isLightMode {
                self.dateLabel.textColor = .white
            }
            self.circle.backgroundColor = WColors.purple
        } else {
            self.circle.backgroundColor = WColors.purple?.withAlphaComponent(0.05)
        }
    }
    
    private func configure() {
        addSubviews([circle, dateLabel, dotView])
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.textAlignment = .center
        
        dotView.backgroundColor = WColors.green
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.addCornerRadius(radius: 17.5)
        
        if cellSelected {
            circle.backgroundColor = WColors.purple
        }
        
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
            circle.heightAnchor.constraint(equalToConstant: 35),
            circle.widthAnchor.constraint(equalToConstant: 35),
            
            dotView.centerXAnchor.constraint(equalTo: circle.centerXAnchor, constant: 15),
            dotView.centerYAnchor.constraint(equalTo: circle.centerYAnchor, constant: -15),
            dotView.heightAnchor.constraint(equalToConstant: 6),
            dotView.widthAnchor.constraint(equalToConstant: 6),
            
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}


