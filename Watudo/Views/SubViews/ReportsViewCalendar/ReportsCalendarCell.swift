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
    
    var cellSelected: Bool = false {
        didSet {
            selectionChanged()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(forDate: String) {
        configure()
        dateLabel.text = forDate
    }
    
    func setColor(forAlpha: Double) {
        dateLabel.textColor = WColors.foreground?.withAlphaComponent(forAlpha)
    }
    
    private func selectionChanged() {
        if cellSelected {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self else { return }
                self.circle.backgroundColor = WColors.purple
            }
        } else {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self else { return }
                self.circle.backgroundColor = WColors.foreground?.withAlphaComponent(0.05)
            }
        }
    }
    
    private func configure() {
        addSubviews([circle, dateLabel])
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.textAlignment = .center
        
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
            
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 40),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
