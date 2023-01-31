//
//  ReportsView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 09/01/2023.
//

import UIKit
import JTAppleCalendar

class ReportsView: UIView {

    let scrollView = UIScrollView()
    
    var myCalendarView = UIView() {
        didSet {
            configure()
            print("Reloading views")
        }
    }
    let reportsChartView = ReportsChartView()
    
    let tableView = UITableView()
    
    var tableHeight: CGFloat = 225
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
        tableView.register(ActivityCell.self, forCellReuseIdentifier: ActivityCell.reuseID)
    }
    
    func setView(calendarView: UIView, tableHeight: CGFloat) {
        self.myCalendarView = calendarView
        self.tableHeight = tableHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubview(scrollView)
        scrollView.addSubviews([myCalendarView, reportsChartView, tableView])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = 75
        tableView.separatorStyle = .none
        
        myCalendarView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        if tableHeight > 600 {
            tableHeight = 560
        }
        
        print(tableHeight)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            myCalendarView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            myCalendarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            myCalendarView.heightAnchor.constraint(equalToConstant: 300),
            myCalendarView.widthAnchor.constraint(equalToConstant: 350),
            
            reportsChartView.topAnchor.constraint(equalTo: myCalendarView.bottomAnchor, constant: 20),
            reportsChartView.centerXAnchor.constraint(equalTo: centerXAnchor),
            reportsChartView.heightAnchor.constraint(equalToConstant: 300),
            reportsChartView.widthAnchor.constraint(equalToConstant: 350),
            
            tableView.topAnchor.constraint(equalTo: reportsChartView.bottomAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.heightAnchor.constraint(equalToConstant: tableHeight),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
}


