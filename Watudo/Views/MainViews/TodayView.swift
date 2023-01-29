//
//  TodayView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit
import Charts
import Lottie

class TodayView: UIView {
    
    let quoteLabel = UILabel()
    let quoteBackground = WVisualEffectView()
    
    let authorLabel = UILabel()
    
    let weekSummaryLabel = UILabel()
    let activitiesLabel = UILabel()

    let chartView = HomeChartView()
    
    let addButton = UIButton()
    
    let tableView = UITableView()
    
    var activities: [Activity] = [
//        Activity(name: "Coding"), Activity(name: "Gaming")
    ]
    
    var heightOfQuoteLabel: CGFloat = 0
    
    
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
    
    func setQuote(quote: String?, author: String?) {
        UIView.transition(with: quoteLabel, duration: 0.3, options: [.transitionCrossDissolve]) {
            self.quoteLabel.text = quote ?? ""
            self.authorLabel.text = author ?? ""
        }
    }
    
    private func configureLabels() {
        let isLightMode = traitCollection.userInterfaceStyle == .light ? true : false
        
        addSubviews([quoteBackground, quoteLabel, authorLabel, weekSummaryLabel, activitiesLabel])
        
        weekSummaryLabel.text = "Week summary"
        weekSummaryLabel.font = UIFont(name: "Panton-BlackCaps", size: 20)
        weekSummaryLabel.textColor = WColors.foreground
        
        activitiesLabel.text = "Activities"
        activitiesLabel.font = UIFont(name: "Panton-BlackCaps", size: 20)
        activitiesLabel.textColor = WColors.foreground
        
        quoteLabel.numberOfLines = 0
        quoteLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        quoteLabel.font = .systemFont(ofSize: 13)
        quoteLabel.textAlignment = .center
        
        quoteLabel.textColor = WColors.foreground
        quoteLabel.contentMode = .scaleAspectFit
        
        authorLabel.font = .boldSystemFont(ofSize: 10)
        authorLabel.textAlignment = .right
        authorLabel.textColor = WColors.foreground
        
        quoteBackground.backgroundColor = WColors.foreground?.withAlphaComponent(0.05)
        
        if isLightMode {
            quoteBackground.addShadowToView(shadowColor: WColors.purple!, offset: CGSize(width: 0, height: 20), shadowRadius: 30, shadowOpacity: 0.5, cornerRadius: 20)
        } else {
            quoteBackground.addCornerRadius(radius: 20)
        }
    }
    
    private func configureAddButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)), for: .normal)
        addButton.tintColor = WColors.purple!
        
        addButton.addTarget(nil, action: #selector(TodayViewActionHandler.addActivityButtonTapped), for: .touchUpInside)
    }
    
    private func configureChart() {
        addSubview(chartView)
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ActivityCell.self, forCellReuseIdentifier: ActivityCell.reuseID)
        tableView.rowHeight = 75
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 30
        
    }
    
    func configureConstraints() {
        
        NSLayoutConstraint.activate([
            quoteBackground.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            quoteBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            quoteBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            quoteBackground.heightAnchor.constraint(equalToConstant: 70),
            
            quoteLabel.topAnchor.constraint(equalTo: quoteBackground.topAnchor, constant: 5),
            quoteLabel.leadingAnchor.constraint(equalTo: quoteBackground.leadingAnchor, constant: 10),
            quoteLabel.trailingAnchor.constraint(equalTo: quoteBackground.trailingAnchor, constant: -10),
            quoteLabel.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: -10),
            
            authorLabel.trailingAnchor.constraint(equalTo: quoteBackground.trailingAnchor, constant: -20),
            authorLabel.bottomAnchor.constraint(equalTo: quoteBackground.bottomAnchor, constant: -5),
            authorLabel.heightAnchor.constraint(equalToConstant: 15),
            authorLabel.widthAnchor.constraint(equalToConstant: 200),
            
            weekSummaryLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 20),
            weekSummaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            weekSummaryLabel.heightAnchor.constraint(equalToConstant: 50),
            weekSummaryLabel.widthAnchor.constraint(equalToConstant: 250),
            
            chartView.topAnchor.constraint(equalTo: weekSummaryLabel.bottomAnchor, constant: 10),
            chartView.centerXAnchor.constraint(equalTo: centerXAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 200),
            chartView.widthAnchor.constraint(equalToConstant: 330),
            
            addButton.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 30),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            
            activitiesLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            activitiesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            activitiesLabel.heightAnchor.constraint(equalToConstant: 50),
            activitiesLabel.widthAnchor.constraint(equalToConstant: 150),
            
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

@objc protocol TodayViewActionHandler {
    func addActivityButtonTapped()
}

extension TodayView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        resetViewsForNewInterfaceStyle(previousTraitCollection)
    }

    func resetViewsForNewInterfaceStyle(_ previousTraitCollection: UITraitCollection?) {
        switch previousTraitCollection?.userInterfaceStyle {
            // Change from light mode to dark mode.
        case .light:
            quoteBackground.addShadowToView(shadowColor: .clear, offset: CGSize(width: 0, height: 20), shadowRadius: 30, shadowOpacity: 0.5, cornerRadius: 10)

            // Change from dark mode to light mode.
        case .dark:
            quoteBackground.addShadowToView(shadowColor: WColors.purple!, offset: CGSize(width: 0, height: 20), shadowRadius: 30, shadowOpacity: 0.7, cornerRadius: 10)

        default:
            // Do nothing, view shouldn't change.
            print("We have no information about user interface style")
        }
    }
}
