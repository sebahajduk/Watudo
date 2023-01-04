//
//  HomeView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit
import Charts

class HomeView: UIView {
    
    let weekSummaryLabel = UILabel()
    let activitiesLabel = UILabel()

    let chartView = HomeChartView()
    
    let addButton = UIButton()
    
    let tableView = UITableView()
    
    var activities: [Activity] = [Activity(name: "Coding"), Activity(name: "Gaming")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureLabels()
        configureChart()
        configureAddButton()
        configureTableView()
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabels() {
        addSubviews([weekSummaryLabel, activitiesLabel])
        weekSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        activitiesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weekSummaryLabel.text = "Week summary"
        weekSummaryLabel.font = UIFont(name: "Panton-BlackCaps", size: 20)
        weekSummaryLabel.textColor = WColors.purple!
        
        activitiesLabel.text = "Activities"
        activitiesLabel.font = UIFont(name: "Panton-BlackCaps", size: 20)
        activitiesLabel.textColor = WColors.purple!
    }
    
    private func configureAddButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)), for: .normal)
        addButton.tintColor = WColors.purple!
        
        addButton.addTarget(nil, action: #selector(HomeViewActionHandler.addActivityButtonTapped), for: .touchUpInside)
    }
    
    private func configureChart() {
        addSubview(chartView)
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ActivityCell.self, forCellReuseIdentifier: ActivityCell.reuseID)
        tableView.rowHeight = 75
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            weekSummaryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            weekSummaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weekSummaryLabel.widthAnchor.constraint(equalToConstant: 250),
            weekSummaryLabel.heightAnchor.constraint(equalToConstant: 50),
            
            chartView.topAnchor.constraint(equalTo: weekSummaryLabel.bottomAnchor, constant: 10),
            chartView.centerXAnchor.constraint(equalTo: centerXAnchor),
            chartView.widthAnchor.constraint(equalToConstant: 330),
            chartView.heightAnchor.constraint(equalToConstant: 200),
            
            addButton.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            
            activitiesLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            activitiesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            activitiesLabel.widthAnchor.constraint(equalToConstant: 150),
            activitiesLabel.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

@objc protocol HomeViewActionHandler {
    func addActivityButtonTapped()
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as! ActivityCell
        
        cell.set(activityName: activities[indexPath.row].name)
        
        return cell
    }
    
    
}
