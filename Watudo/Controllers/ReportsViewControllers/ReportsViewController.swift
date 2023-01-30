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
    var user: User? = nil

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        
        configure()
    }
    
    func setVC(user: User) {
        self.user = user
    }
    
    private func configure() {
        let reportsView = ReportsView(calendarView: myCalendarVC.view)
        reportsView.reportsChartView.chartView.delegate = self
        view.addSubviews([reportsView])
        
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
