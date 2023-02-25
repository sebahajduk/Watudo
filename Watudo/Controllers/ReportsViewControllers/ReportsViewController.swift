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
    
    let myCalendarVC = ReportsCalViewController()
    
    let reportsView = ReportsView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        myCalendarVC.delegate = self
        reportsView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        
        configure()
    }
    
    private func configure() {
        reportsView.setView(calendarView: myCalendarVC.view, tableHeight: 1000)
        reportsView.reportsChartView.chartView.delegate = self
        view.addSubviews([reportsView])
        
        reportsView.tableView.dataSource = self
        reportsView.tableView.delegate = self
        
        NSLayoutConstraint.activate([
            reportsView.topAnchor.constraint(equalTo: view.topAnchor),
            reportsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reportsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reportsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateCharts(categorySpentHistory: [String:Double]) {
        let categories = LocalUserManager.shared.getCategories()
        var categoriesWithHistory: [Category] = []
    
        for category in categories where categorySpentHistory[category.name] != nil {
            categoriesWithHistory.append(category)
            print("Name: \(category.name), color: \(category.colorHEX)")
        }
        
        reportsView.reportsChartView.setData(categories: categoriesWithHistory, categorySpentHistory: categorySpentHistory)
     }
}

extension ReportsViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LocalUserManager.shared.getActivitiesForCategory(at: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as! ActivityCell
        
        let activities = LocalUserManager.shared.getActivitiesForCategory(at: indexPath.section)
        
        cell.set(for: activities[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        LocalUserManager.shared.getCategory(for: section).name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        LocalUserManager.shared.getNumberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = WColors.background
        let header = view as! UITableViewHeaderFooterView
        var content = header.defaultContentConfiguration()
        content.text = LocalUserManager.shared.getCategory(for: section).name
        content.textProperties.color = WColors.green!
        content.textProperties.font = .boldSystemFont(ofSize: 13)
        header.contentConfiguration = content
    }
    
}

extension ReportsViewController: ReportsCalVCDelegate {
    func dateSelected(dates: [String]) {
        var timeSpentHistory: [String:Double] = [:]
        var categorySpentHistory: [String:Double] = [:]
        
        for date in dates {
            if myCalendarVC.calendarDataSource[date] == nil { continue } else {
                for activity in myCalendarVC.calendarDataSource[date]! {
                    if timeSpentHistory[activity.name] == nil {
                        timeSpentHistory[activity.name] = activity.timeSpent
                    } else {
                        timeSpentHistory[activity.name]! += activity.timeSpent
                    }
                    
                    if categorySpentHistory[activity.category.name] == nil {
                        categorySpentHistory[activity.category.name] = activity.timeSpent
                    } else {
                        categorySpentHistory[activity.category.name]! += activity.timeSpent
                    }
                }
            }
            updateCharts(categorySpentHistory: categorySpentHistory)
        }
    }
}
