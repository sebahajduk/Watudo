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
    var user: User?
    let reportsView = ReportsView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        reportsView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        
        configure()
    }
    
    func setVC(user: User) {
        self.user = user
    }
    
    private func calculateTableViewHeight() -> CGFloat {
        var activitiesCount = 0
        for category in user!.categories {
            activitiesCount += category.activities.count
        }
        
        return CGFloat(activitiesCount * 75)
    }
    
    private func configure() {
        reportsView.setView(calendarView: myCalendarVC.view, tableHeight: calculateTableViewHeight())
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
}

extension ReportsViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let user else { return 0 }
        
        return user.categories[section].activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as! ActivityCell
        
        guard let user else { return cell }
        cell.set(activityName: user.categories[indexPath.section].activities[indexPath.row].name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return user?.categories[section].name ?? ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return user?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = WColors.background
        let header = view as! UITableViewHeaderFooterView
        var content = header.defaultContentConfiguration()
        content.text = user?.categories[section].name ?? ""
        content.textProperties.color = WColors.green!
        content.textProperties.font = .boldSystemFont(ofSize: 13)
        header.contentConfiguration = content
    }
    
}
