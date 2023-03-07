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
    
    private let myCalendarVC = ReportsCalViewController()
    private let reportsView = ReportsView()
    private var activitiesHistory: [Activity] = []
    private var categoriesWithHistory: [Category] = []

    //MARK: Lifecycle
    
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
    
    //MARK: Configuring UI
    
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
    
    //MARK: Logic
    
    private func getUniqueCategoryList(from activities: [Activity]) {
        var categories: [Category] = []
        
        for activity in activities {
            guard !categories.contains(activity.category) else { continue }
            
            categories.append(activity.category)
        }
        print(categories)
        self.categoriesWithHistory = categories
    }
}

extension ReportsViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let activities = activitiesHistory.filter { $0.category ==  categoriesWithHistory[section]}
        
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as! ActivityCell
        let activities = activitiesHistory.filter { $0.category ==  categoriesWithHistory[indexPath.section]}
        
        cell.set(for: activities[indexPath.row], style: .report)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        categoriesWithHistory[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        categoriesWithHistory.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = WColors.background
        let header = view as! UITableViewHeaderFooterView
        var content = header.defaultContentConfiguration()
        content.text = categoriesWithHistory[section].name
        content.textProperties.color = WColors.green!
        content.textProperties.font = .boldSystemFont(ofSize: 13)
        header.contentConfiguration = content
    }
    
}

extension ReportsViewController: ReportsCalVCDelegate {
    func dateSelected(dates: [String]) {
        updateActivitiesList(dates: dates)
        updateCharts(dates: dates)
        
        reportsView.tableView.reloadData()
    }
    
    private func updateActivitiesList(dates: [String]) {
        var timeSpentHistory: [Activity] = []
        
        if !dates.isEmpty {
            for date in dates {
                if myCalendarVC.calendarDataSource[date] == nil { continue } else {
                    let history = myCalendarVC.calendarDataSource[date]
                    
                    for activity in myCalendarVC.calendarDataSource[date]! {
                        if timeSpentHistory.contains(activity) {
                            guard let index = timeSpentHistory.firstIndex(where: { $0 == activity }) else { return }
                            timeSpentHistory[index].timeSpent += activity.timeSpent
                        } else {
                            timeSpentHistory.append(activity)
                        }
                    }
                }
            }
            self.activitiesHistory = timeSpentHistory
            getUniqueCategoryList(from: timeSpentHistory)
        } else {
            self.categoriesWithHistory = []
            self.activitiesHistory = []
        }
        
    }
    
    private func updateCharts(dates: [String]) {
        let categories = LocalUserManager.shared.getCategories()
        var categoriesWithHistory: [Category] = []
        var categorySpentHistory: [String:Double] = [:]
        
        for date in dates {
            if myCalendarVC.calendarDataSource[date] == nil { continue } else {
                for activity in myCalendarVC.calendarDataSource[date]! {
                    if categorySpentHistory[activity.category.name] == nil {
                        categorySpentHistory[activity.category.name] = activity.timeSpent
                    } else {
                        categorySpentHistory[activity.category.name]! += activity.timeSpent
                    }
                }
            }
        }
    
        for category in categories where categorySpentHistory[category.name] != nil {
            categoriesWithHistory.append(category)
        }
        
        reportsView.reportsChartView.setData(categories: categoriesWithHistory, categorySpentHistory: categorySpentHistory)
     }
}
