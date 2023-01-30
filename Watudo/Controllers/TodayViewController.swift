//
//  TodayViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit

class TodayViewController: UIViewController {

    var todayView = TodayView()
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background!
        
        todayView.tableView.dataSource = self
        todayView.tableView.delegate = self
        
        view.addSubview(todayView)
        NSLayoutConstraint.activate([
            todayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            todayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        fetchQuote()
    }
    
    func setVC(user: User) {
        self.user = user
    }
    
    func fetchQuote() {
        Task {
            let quoteOfTheDay = await QuoteApiManager.makeRequest()
            todayView.setQuote(quote: quoteOfTheDay?.q, author: quoteOfTheDay?.a)
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

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayView.activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as! ActivityCell
        
        cell.set(activityName: todayView.activities[indexPath.row].name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return User().categories[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return User().categories.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = WColors.background
        let header = view as! UITableViewHeaderFooterView
        var content = header.defaultContentConfiguration()
        content.text = User().categories[section].name
        content.textProperties.color = WColors.green!
        content.textProperties.font = .boldSystemFont(ofSize: 13)
        header.contentConfiguration = content
    }
}
