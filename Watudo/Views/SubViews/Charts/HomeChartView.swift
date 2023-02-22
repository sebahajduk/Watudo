//
//  HomeChartView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 02/01/2023.
//

import UIKit
import Charts

class HomeChartView: UIView {
    
    let visualEffect = WVisualEffectView(cornerRadius: 30)
    var chartView: LineChartView = LineChartView()
    

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
        let isLightMode = traitCollection.userInterfaceStyle == .light ? true : false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        
        visualEffect.backgroundColor = WColors.purple
        
        if isLightMode {
            visualEffect.addShadowToView(shadowColor: WColors.purple!, offset: CGSize(width: 0, height: 20), shadowRadius: 30, shadowOpacity: 0.5, cornerRadius: 20)
            visualEffect.backgroundColor = WColors.purple
        } else {
            visualEffect.addCornerRadius(radius: 20)
            visualEffect.backgroundColor = WColors.foreground?.withAlphaComponent(0.05)

        }
        
        createChart()
        configureConstraints()
    }
    
    func setData(for history: [Double]) {
        let weekDays: [ChartDataEntry] = [
            ChartDataEntry(x: 0, y: history[6]),
            ChartDataEntry(x: 1, y: history[5]),
            ChartDataEntry(x: 2, y: history[4]),
            ChartDataEntry(x: 3, y: history[3]),
            ChartDataEntry(x: 4, y: history[2]),
            ChartDataEntry(x: 5, y: history[1]),
            ChartDataEntry(x: 6, y: history[0])
        ]
        
        let presentWeek = LineChartDataSet(entries: weekDays)
        
        let gradientColors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0.05).cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object

        presentWeek.drawCirclesEnabled = false
        presentWeek.mode = .linear
        presentWeek.lineWidth = 2
        presentWeek.setColor(.white)
        presentWeek.fill = LinearGradientFill(gradient: gradient!, angle: 90)
        
        presentWeek.fillAlpha = 0.4
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
        chartView.leftAxis.gridColor = .white.withAlphaComponent(0.2)
        chartView.leftAxis.axisLineColor = .white
        chartView.leftAxis.labelTextColor = .white
        
        chartView.xAxis.gridColor = .white.withAlphaComponent(0.2)
        chartView.xAxis.axisLineColor = .white
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        
        chartView.xAxis.labelPosition = .bottom
        chartView.doubleTapToZoomEnabled = false
        chartView.legend.enabled = false
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
        
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

extension TodayView: ChartViewDelegate {
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
            visualEffect.addShadowToView(shadowColor: .clear, offset: CGSize(width: 0, height: 20), shadowRadius: 30, shadowOpacity: 0.5, cornerRadius: 10)
            visualEffect.backgroundColor = WColors.foreground?.withAlphaComponent(0.05)

            // Change from dark mode to light mode.
        case .dark:
            visualEffect.addShadowToView(shadowColor: WColors.purple!, offset: CGSize(width: 0, height: 20), shadowRadius: 30, shadowOpacity: 0.7, cornerRadius: 10)
            visualEffect.backgroundColor = WColors.purple


        default:
            // Do nothing, view shouldn't change.
            print("We have no information about user interface style")
        }
    }
}
