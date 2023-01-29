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
    
    let categories: [Category] = [
        Category(name: "Coding", color: WColors.green!),
        Category(name: "Netflix", color: .yellow),
        Category(name: "Gaming", color: .gray),
        Category(name: "House chores", color: .blue)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    func setData() {
        for category in categories {
            if let index = categories.firstIndex(of: category) {
                let chartValue = BarChartDataEntry(x: Double(index), y: category.timeSpend)
                let dataSet = BarChartDataSet(entries: [chartValue], label: category.name)
                dataSet.colors = [category.color.withAlphaComponent(0.2)]
                dataSet.barBorderWidth = 2
                dataSet.barBorderColor = category.color
                
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
            visualEffect.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffect.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffect.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            chartView.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 10),
            chartView.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 10),
            chartView.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -10),
            chartView.bottomAnchor.constraint(equalTo: visualEffect.bottomAnchor, constant: -10)
        ])
    }
}


