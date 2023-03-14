//
//  ReportsViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit
import JTAppleCalendar
import Charts

class ReportsViewController: UIViewController {

    private let myCalendarVC = ReportsCalViewController()
    private let reportsView = ReportsView()
    private var activitiesHistory: [Activity] = []
    private var categoriesWithHistory: [Category] = []
    private var timeSpentHistory: [Activity] = []

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background

        configure()
    }

    // MARK: Configuring UI
    private func configure() {
        reportsView.setView(calendarView: myCalendarVC.view, tableHeight: 1000)
        reportsView.reportsChartView.chartView.delegate = self
        view.addSubviews([reportsView])

        reportsView.tableView.dataSource = self
        reportsView.tableView.delegate = self
        myCalendarVC.delegate = self

        NSLayoutConstraint.activate([
            reportsView.topAnchor.constraint(equalTo: view.topAnchor),
            reportsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reportsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reportsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: Logic
    private func getUniqueCategoryList(from activities: [Activity]) {
        var categories: [Category] = []

        for activity in activities {
            guard !categories.contains(activity.category) else { continue }

            categories.append(activity.category)
        }
        self.categoriesWithHistory = categories
    }
}

// MARK: ChartViewDelegate
extension ReportsViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

// MARK: ReportsView table view delegate and data source
extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let allActivities = activitiesHistory.filter { $0.category ==  categoriesWithHistory[section]}
        var countedActivities: [Activity] = []

        for activity in allActivities {
            if countedActivities.firstIndex(where: { $0.id == activity.id }) != nil {
                continue
            } else {
                countedActivities.append(activity)
            }
        }

        return countedActivities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as? ActivityCell else {
            return UITableViewCell()
        }
        let allActivities = activitiesHistory.filter { $0.category ==  categoriesWithHistory[indexPath.section]}
        var countedActivities: [Activity] = []

        for activity in allActivities {
            if let index = countedActivities.firstIndex(where: { $0.id == activity.id }) {
                countedActivities[index].timeSpent += activity.timeSpent
            } else {
                countedActivities.append(activity)
            }
        }

        cell.set(for: countedActivities[indexPath.row], style: .report)
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
        guard let header = view as? UITableViewHeaderFooterView else { return }
        var content = header.defaultContentConfiguration()
        content.text = categoriesWithHistory[section].name
        content.textProperties.color = WColors.green!
        content.textProperties.font = .boldSystemFont(ofSize: 13)
        header.contentConfiguration = content
    }

}

// MARK: Calendar delegate
extension ReportsViewController: ReportsCalVCDelegate {
    func dateSelected(dates: [String]) {
        updateActivitiesList(dates: dates)
        updateCharts()

        reportsView.tableView.reloadData()
    }

    private func updateActivitiesList(dates: [String]) {
        timeSpentHistory = []
        self.activitiesHistory = []

        if !dates.isEmpty {
            for date in dates {
                if myCalendarVC.calendarDataSource[date] == nil { continue } else {
                    for activity in myCalendarVC.calendarDataSource[date]! {
                        if let index = timeSpentHistory.firstIndex(where: { $0.name == activity.name }) {
                            timeSpentHistory[index].timeSpent += activity.timeSpent
                        } else {
                            timeSpentHistory.append(activity)
                        }
                    }
                }
            }
            self.activitiesHistory = timeSpentHistory
        } else {
            timeSpentHistory = []
            self.categoriesWithHistory = []
            self.activitiesHistory = timeSpentHistory
        }
    }

    private func updateCharts() {
        var categorySpentHistory: [String: Double] = [:]
        getUniqueCategoryList(from: timeSpentHistory)

        for activity in timeSpentHistory {
            if categorySpentHistory[activity.category.name] == nil {
                categorySpentHistory[activity.category.name] = activity.timeSpent
            } else {
                categorySpentHistory[activity.category.name]! += activity.timeSpent
            }
        }

        reportsView.reportsChartView.setData(categories: categoriesWithHistory,
                                             categorySpentHistory: categorySpentHistory)
     }
}
