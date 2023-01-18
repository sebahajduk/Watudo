//
//  ReportsViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit
import JTAppleCalendar
import Charts

class ReportsViewController: UIViewController  {
    
    let myCalendarView = ReportsCalendarView()
    let reportsChartView = ReportsChartView()
    
    var calendar: JTACMonthView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        
        view.addSubviews([myCalendarView, reportsChartView])
        calendar = myCalendarView.myCalendar
        myCalendarView.myCalendar.calendarDelegate = self
        myCalendarView.myCalendar.calendarDataSource = self
        reportsChartView.chartView.delegate = self
        myCalendarView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            myCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myCalendarView.heightAnchor.constraint(equalToConstant: 300),
            
            reportsChartView.topAnchor.constraint(equalTo: myCalendarView.bottomAnchor, constant: 20),
            reportsChartView.leadingAnchor.constraint(equalTo: myCalendarView.leadingAnchor),
            reportsChartView.trailingAnchor.constraint(equalTo: myCalendarView.trailingAnchor),
            reportsChartView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension ReportsViewController: JTACMonthViewDelegate, JTACMonthViewDataSource {
    
    //MARK: JTACMonthViewDelegate
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell!, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell!, cellState: cellState)
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
    
    
    // Handling cell configuration depending on date and selection.
    func configureCell(view: JTACDayCell, cellState: CellState) {
        guard let cell =
                view as? ReportsCalendarCell else { return }
        cell.set(forDate: cellState.text)
        handleCellSelected(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
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

extension ReportsViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
