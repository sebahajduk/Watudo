//
//  ReportsViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit
import JTAppleCalendar

class ReportsViewController: UIViewController {

    let myCalendar = JTACMonthView()
    
    let monthLabal = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        
        view.addSubview(myCalendar)
        myCalendar.translatesAutoresizingMaskIntoConstraints = false
        myCalendar.layer.cornerRadius = 10
        myCalendar.clipsToBounds = true
        myCalendar.register(ReportsCalendarCell.self, forCellWithReuseIdentifier: ReportsCalendarCell.reuseID)
        myCalendar.minimumLineSpacing = 0
        myCalendar.calendarDelegate = self
        myCalendar.calendarDataSource = self
        myCalendar.scrollDirection = .horizontal
        myCalendar.isPagingEnabled = true
        myCalendar.showsHorizontalScrollIndicator = false
        
        myCalendar.register(ReportsCalendarHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ReportsCalendarHeader")
        
        view.addSubview(monthLabal)
        monthLabal.translatesAutoresizingMaskIntoConstraints = false
        monthLabal.textAlignment = .center
        
        NSLayoutConstraint.activate([
            monthLabal.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            monthLabal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            monthLabal.heightAnchor.constraint(equalToConstant: 20),
            monthLabal.widthAnchor.constraint(equalToConstant: 100),
            
            myCalendar.topAnchor.constraint(equalTo: monthLabal.bottomAnchor, constant: 20),
            myCalendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myCalendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myCalendar.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension ReportsViewController: JTACMonthViewDelegate, JTACMonthViewDataSource {
    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, willDisplay cell: JTAppleCalendar.JTACDayCell, forItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, cellForItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) -> JTAppleCalendar.JTACDayCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: ReportsCalendarCell.reuseID, for: indexPath) as! ReportsCalendarCell
        
        self.calendar(myCalendar, willDisplay: cell,forItemAt: date, cellState: cellState, indexPath: indexPath)
        
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendar.JTACMonthView) -> JTAppleCalendar.ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2021 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
    
    func configureCell(view: JTACDayCell, cellState: CellState) {
        guard let cell =
                view as? ReportsCalendarCell else { return }
        
        cell.set(forDate: cellState.text)
        
        handleCellTextColor(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: ReportsCalendarCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.setColor(forAlpha: 1.0)
        } else {
            cell.setColor(forAlpha: 0.3)
        }
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM yyyy"
        
        let header = myCalendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: ReportsCalendarHeader.reuseID, for: indexPath) as! ReportsCalendarHeader
        header.set(month: formatter.string(from: range.start))
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 30)
    }
}
