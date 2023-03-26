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
    let addActivityButton = UIButton()
    let addCategoryButton = UIButton()
    let tableView = UITableView()
    let scrollView = UIScrollView()

    var activities: [Activity] = []
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

        addSubviews([scrollView])
        scrollView.addSubviews([quoteBackground, quoteLabel, authorLabel, weekSummaryLabel, activitiesLabel])

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
            quoteBackground.addShadowToView(shadowColor: WColors.purple!,
                                            offset: CGSize(width: 0, height: 20),
                                            shadowRadius: 30,
                                            shadowOpacity: 0.5,
                                            cornerRadius: 20)
        } else {
            quoteBackground.addCornerRadius(radius: 20)
        }
    }

    private func configureAddButton() {
        scrollView.addSubviews([addCategoryButton, addActivityButton])

        addActivityButton.setImage(UIImage(systemName: "gauge.medium.badge.plus",
                                   withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)),
                           for: .normal)
        addCategoryButton.setImage(UIImage(systemName: "folder.badge.plus",
                                        withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)),
                                    for: .normal)

        addActivityButton.tintColor = WColors.purple!
        addCategoryButton.tintColor = WColors.purple!

        addActivityButton.addTarget(nil,
                                    action: #selector(TodayViewActionHandler.addActivityButtonTapped),
                                    for: .touchUpInside)
        addCategoryButton.addTarget(nil,
                                    action: #selector(TodayViewActionHandler.addCategoryButtonTapped),
                                    for: .touchUpInside)
    }

    private func configureChart() {
        addSubview(chartView)
    }

    private func configureTableView() {
        scrollView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ActivityCell.self, forCellReuseIdentifier: ActivityCell.reuseID)
        tableView.rowHeight = 75

        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 30
        tableView.sectionHeaderTopPadding = 5
    }

    func configureConstraints() {

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            quoteBackground.topAnchor.constraint(equalTo: scrollView.topAnchor),
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

            addCategoryButton.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 30),
            addCategoryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            addCategoryButton.heightAnchor.constraint(equalToConstant: 35),
            addCategoryButton.widthAnchor.constraint(equalToConstant: 35),

            addActivityButton.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 30),
            addActivityButton.trailingAnchor.constraint(equalTo: addCategoryButton.leadingAnchor, constant: -10),
            addActivityButton.heightAnchor.constraint(equalToConstant: 35),
            addActivityButton.widthAnchor.constraint(equalToConstant: 35),

            activitiesLabel.centerYAnchor.constraint(equalTo: addActivityButton.centerYAnchor),
            activitiesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            activitiesLabel.heightAnchor.constraint(equalToConstant: 25),
            activitiesLabel.widthAnchor.constraint(equalToConstant: 150),

            tableView.topAnchor.constraint(equalToSystemSpacingBelow: addActivityButton.bottomAnchor, multiplier: 1),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 500),
            tableView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}

@objc protocol TodayViewActionHandler {
    func addActivityButtonTapped()
    func addCategoryButtonTapped()
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
            quoteBackground.addShadowToView(shadowColor: .clear,
                                            offset: CGSize(width: 0, height: 20),
                                            shadowRadius: 30,
                                            shadowOpacity: 0.5,
                                            cornerRadius: 10)

            // Change from dark mode to light mode.
        case .dark:
            quoteBackground.addShadowToView(shadowColor: WColors.purple!,
                                            offset: CGSize(width: 0, height: 20),
                                            shadowRadius: 30,
                                            shadowOpacity: 0.7,
                                            cornerRadius: 10)

        default:
            // Do nothing, view shouldn't change.
            print("We have no information about user interface style")
        }
    }
}

extension TodayView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
