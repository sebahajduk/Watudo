//
//  ReportsCalendarViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 10/01/2023.
//

import UIKit
import JTAppleCalendar

class ReportsCalendarViewController: UIViewController {
    let calendarView = ReportsCalendarView()
    var myCalendar: JTACMonthView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        calendarView.myCalendar.calendarDelegate = self
        calendarView.myCalendar.calendarDataSource = self
    }
    
    private func configure() {
        view.addSubview(calendarView)
        myCalendar = calendarView.myCalendar
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ReportsCalendarViewController: JTACMonthViewDelegate, JTACMonthViewDataSource {
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
        
        var dateComponent = DateComponents()
        dateComponent.month = 3
        
        guard let endDate = Calendar.current.date(byAdding: dateComponent, to: Date()) else {
            return ConfigurationParameters(startDate: startDate, endDate: Date())
        }
        
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
        return MonthSize(defaultSize: 35)
    }
}
