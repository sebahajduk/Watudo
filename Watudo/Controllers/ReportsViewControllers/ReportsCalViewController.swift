//
//  ReportsCalViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/01/2023.
//

import UIKit
import JTAppleCalendar

class ReportsCalViewController: UIViewController {
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    let myCalendarView = ReportsCalendarView()
    var calendar: JTACMonthView!
    var delegate: ReportsCalVCDelegate? = nil
    
    var calendarDataSource: [String:[Activity]] = [:] {
        didSet {
            calendar.reloadData()
        }
    }
    var selectedDates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar = myCalendarView.myCalendar
        calendar.calendarDelegate = self
        calendar.calendarDataSource = self

        populateDataSource()
        
        view.addSubviews([myCalendarView])
        
        NSLayoutConstraint.activate([
            myCalendarView.topAnchor.constraint(equalTo: view.topAnchor),
            myCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myCalendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ReportsCalViewController: JTACMonthViewDelegate, JTACMonthViewDataSource {
    
    //MARK: JTACMonthViewDelegate
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell!, cellState: cellState)
        selectedDates.append(formatter.string(from: cellState.date))
        delegate?.dateSelected(dates: selectedDates)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell!, cellState: cellState)
        
        guard let index = selectedDates.firstIndex(where: { $0 == formatter.string(from: cellState.date)}) else { return }
        
        selectedDates.remove(at: index)
        delegate?.dateSelected(dates: selectedDates)
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        return true
    }
    
    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, willDisplay cell: JTAppleCalendar.JTACDayCell, forItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, cellForItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) -> JTAppleCalendar.JTACDayCell {
        
        let cell = calendar.dequeueReusableCell(withReuseIdentifier: ReportsCalendarCell.reuseID, for: indexPath) as! ReportsCalendarCell
        self.calendar(calendar, willDisplay: cell,forItemAt: date, cellState: cellState, indexPath: indexPath)
        
        return cell
    }
    
    //MARK: JTACMonthViewDataSource
    func configureCalendar(_ calendar: JTAppleCalendar.JTACMonthView) -> JTAppleCalendar.ConfigurationParameters {
        
        let startDate = formatter.date(from: "2021-01-01")!
        
        var dateComponent = DateComponents()
        dateComponent.month = 3
        
        guard let endDate = Calendar.current.date(byAdding: dateComponent, to: Date()) else {
            return ConfigurationParameters(startDate: startDate, endDate: Date())
        }
        
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
    
    
    // Handling cell configuration depending on date and selection.
    func configureCell(view: JTACDayCell, cellState: CellState) {
        guard let cell =
                view as? ReportsCalendarCell else { return }
        cell.set(forDate: cellState.text)
        handleCellSelected(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellEvents(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: ReportsCalendarCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.setColor(forAlpha: 1.0)
        } else {
            cell.setColor(forAlpha: 0.3)
        }
        
        let today = Date().formatted(date: .numeric, time: .omitted)
        let cellStateTime = cellState.date.formatted(date: .numeric, time: .omitted)
        let isToday: Bool = today == cellStateTime ? true : false
        
        if isToday && !cellState.isSelected {
            cell.isToday = true
        }
    }
    
    func handleCellSelected(cell: ReportsCalendarCell, cellState: CellState) {
        if cellState.isSelected {
            cell.cellSelected = true
        } else {
            cell.cellSelected = false
        }
    }
    
    func handleCellEvents(cell: ReportsCalendarCell, cellState: CellState) {
        let dataString = formatter.string(from: cellState.date)
        
        if calendarDataSource[dataString] == nil {
            cell.dotView.isHidden = true
        } else {
            cell.dotView.isHidden = false
        }
    }
    
    func populateDataSource() {
        // TODO: Here you should download data from a server
        
        FirebaseManager.shared.fetchActivitiesByDate() { result in
            switch result {
            case .success(let success):
                self.calendarDataSource = success
            case .failure(let failure):
                print("Upst")
            }
        }
            
        
    }
    
    // Configuring calendar header.
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM yyyy"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: ReportsCalendarHeader.reuseID, for: indexPath) as! ReportsCalendarHeader
        header.set(month: formatter.string(from: range.start))
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 35)
    }
}

protocol ReportsCalVCDelegate {
    func dateSelected(dates: [String])
}
