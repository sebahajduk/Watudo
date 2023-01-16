//
//  ReportsChartView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 16/01/2023.
//

import UIKit
import Charts

class ReportsChartView: UIView {
    
    let visualEffect = WVisualEffectView(cornerRadius: 30)
    var chartView: BarChartView = BarChartView()
    var chartValues: [BarChartDataEntry] = []
    var summary: [BarChartDataSet] = []
    
    let activities: [Activity] = [
        Activity(name: "Coding", timeSpent: 1.5),
        Activity(name: "Gaming", timeSpent: 8.5),
        Activity(name: "Household", timeSpent: 3.5),
        Activity(name: "Netflix", timeSpent: 5.5)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    func setData() {
        for activity in activities {
            if let index = activities.firstIndex(of: activity) {
                let chartValue = BarChartDataEntry(x: Double(index), y: activity.timeSpent)
                let dataSet = BarChartDataSet(entries: [chartValue], label: activity.name)
                dataSet.colors = [WColors.purple!]
                summary.append(dataSet)
            }
        }
        
        let data = BarChartData(dataSets: summary)
        data.barWidth = 0.5
        chartView.data = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(visualEffect)
        
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        
        createChart()
        configureConstraints()
    }
    
    private func createChart() {
        addSubview(chartView)
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.gridColor = WColors.purple!.withAlphaComponent(0.2)
        chartView.leftAxis.axisLineColor = WColors.purple!
        chartView.leftAxis.labelTextColor = WColors.foreground!
        
        chartView.xAxis.gridColor = WColors.purple!.withAlphaComponent(0.2)
        chartView.xAxis.axisLineColor = WColors.purple!
        chartView.xAxis.labelTextColor = WColors.foreground!
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        
        chartView.xAxis.enabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.legend.enabled = true
        setData()
        chartView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            visualEffect.topAnchor.constraint(equalTo: topAnchor),
            visualEffect.bottomAnchor.constraint(equalTo: bottomAnchor),
            visualEffect.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffect.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            chartView.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 10),
            chartView.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 10),
            chartView.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -10),
            chartView.bottomAnchor.constraint(equalTo: visualEffect.bottomAnchor, constant: -10)
        ])
    }
}
