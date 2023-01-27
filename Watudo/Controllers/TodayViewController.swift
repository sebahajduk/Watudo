//
//  TodayViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit

class TodayViewController: UIViewController {

    var todayView = TodayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background!
        
        
        view.addSubview(todayView)
        NSLayoutConstraint.activate([
            todayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            todayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        catchData()
    }

    func catchData() {
        Task {
            let quoteOfTheDay = await QuoteApiManager.makeRequest()
            todayView.quoteLabel.text = quoteOfTheDay?.q
            UIView.animate(withDuration: 0.3, delay: 0) { [unowned self] in
                todayView.heightOfQuoteLabel = CGFloat(todayView.quoteLabel.calculateMaxLines() * 15)
            }
        }
    }
    
}

extension TodayViewController: TodayViewActionHandler {
    func addActivityButtonTapped() {
        let addActivityVC = AddActivityViewController()
        
        addActivityVC.sheetPresentationController?.detents = [.medium()]
        addActivityVC.delegate = self
        
        present(addActivityVC, animated: true)
    }
}

extension TodayViewController: SendNewActivityDelegate {
    func sendActivity(activity: Activity) {
        todayView.activities.append(activity)
        todayView.tableView.reloadData()
    }
}
