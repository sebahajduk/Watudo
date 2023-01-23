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
    
    var myCalendarView: UIView!
    let reportsChartView = ReportsChartView()
    
    let tableView = UITableView()
    
    let activities: [Activity] = [
        Activity(name: "Coding"),
        Activity(name: "Gaming"),
        Activity(name: "Netflix"),
        Activity(name: "House chores"),
        Activity(name: "Coding"),
        Activity(name: "Gaming"),
        Activity(name: "Netflix"),
        Activity(name: "House chores"),
        Activity(name: "Coding")
    ]
    
    var tableHeight: CGFloat = 225
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(calendarView: UIView) {
        self.init(frame: .zero)
        self.myCalendarView = calendarView
        configure()
        
        tableView.register(ActivityCell.self, forCellReuseIdentifier: ActivityCell.reuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
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
        
        tableHeight = CGFloat(activities.count * 75)
        
        if tableHeight > 600 {
            tableHeight = 560
        }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            myCalendarView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            myCalendarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            myCalendarView.widthAnchor.constraint(equalToConstant: 350),
            myCalendarView.heightAnchor.constraint(equalToConstant: 300),
            
            reportsChartView.topAnchor.constraint(equalTo: myCalendarView.bottomAnchor, constant: 20),
            reportsChartView.centerXAnchor.constraint(equalTo: centerXAnchor),
            reportsChartView.widthAnchor.constraint(equalToConstant: 350),
            reportsChartView.heightAnchor.constraint(equalToConstant: 300),
            
            tableView.topAnchor.constraint(equalTo: reportsChartView.bottomAnchor, constant: 40),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.heightAnchor.constraint(equalToConstant: tableHeight),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
}

extension ReportsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as! ActivityCell
        
        cell.set(activityName: activities[indexPath.row].name)
        
        return cell
    }
    
    
}
