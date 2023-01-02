//
//  HomeChartView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 02/01/2023.
//

import UIKit
import Charts

class HomeChartView: UIView {
    
    let visualEffect = UIVisualEffectView()
    var chartView: LineChartView = LineChartView()
    let weekDays: [ChartDataEntry] = [
        ChartDataEntry(x: 0, y: 2),
        ChartDataEntry(x: 1, y: 7),
        ChartDataEntry(x: 2, y: 20),
        ChartDataEntry(x: 3, y: 5),
        ChartDataEntry(x: 4, y: 9),
        ChartDataEntry(x: 5, y: 8),
        ChartDataEntry(x: 6, y: 2)
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(visualEffect)
        
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.backgroundColor = .systemBackground
        
        let isLightMode = traitCollection.userInterfaceStyle == .light ? true : false
        
        if isLightMode {
            visualEffect.addShadowToView(shadowColor: WColors.purple!, offset: CGSize(width: 0, height: 0), shadowRadius: 30, shadowOpacity: 0.2, cornerRadius: 30)
        } else {
            visualEffect.addShadowToView(shadowColor: .clear, offset: CGSize(width: 0, height: 0), shadowRadius: 30, shadowOpacity: 0.2, cornerRadius: 30)
        }
        createChart()
        configureConstraints()
    }
    
    func setData() {
        let presentWeek = LineChartDataSet(entries: weekDays)
        
        presentWeek.drawCirclesEnabled = false
        presentWeek.mode = .cubicBezier
        presentWeek.lineWidth = 2
        presentWeek.setColor(WColors.green!)
        presentWeek.fillColor = WColors.green!
        presentWeek.fillAlpha = 0.2
        presentWeek.drawFilledEnabled = true
        presentWeek.drawVerticalHighlightIndicatorEnabled = false
        presentWeek.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSet: presentWeek)
        
        data.setDrawValues(false)
        
        chartView.data = data
    }
    
    private func createChart() {
        addSubview(chartView)
        
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.doubleTapToZoomEnabled = false
        chartView.legend.enabled = false
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
        
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

extension HomeView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

extension HomeChartView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        resetViewsForNewInterfaceStyle(previousTraitCollection)
    }
    
    func resetViewsForNewInterfaceStyle(_ previousTraitCollection: UITraitCollection?) {
        switch previousTraitCollection?.userInterfaceStyle {
            // Change from light mode to dark mode.
        case .light:
            visualEffect.addShadowToView(shadowColor: .clear, offset: CGSize(width: 0, height: 0), shadowRadius: 30, shadowOpacity: 0.2, cornerRadius: 30)
        
            // Change from dark mode to light mode.
        case .dark:
            visualEffect.addShadowToView(shadowColor: WColors.purple!, offset: CGSize(width: 0, height: 20), shadowRadius: 30, shadowOpacity: 0.2, cornerRadius: 30)
            
        default:
            // Do nothing, view shouldn't change.
            print("We have no information about user interface style")
        }
    }
}
