//
//  TodayViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit

class TodayViewController: UIViewController, ActivityDelegate {
    
    var todayView = TodayView()
    
    var user: LocalUser!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background!
        
        todayView.tableView.dataSource = self
        todayView.tableView.delegate = self
        todayView.tableView.allowsMultipleSelection = true
        
        view.addSubview(todayView)
        NSLayoutConstraint.activate([
            todayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            todayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        fetchQuote()
    }
    
    func setVC(user: LocalUser) {
        self.user = user
        
        updateDelegate()
    }
    
    private func updateDelegate() {
        for category in user.categories {
            for activity in user.getActivitiesForCategory(category) {
                activity.delegate = self
            }
        }
    }
    
    func fetchQuote() {
        Task {
            let quoteOfTheDay = await QuoteApiManager.makeRequest()
            todayView.setQuote(quote: quoteOfTheDay?.q, author: quoteOfTheDay?.a)
        }
    }
    
    func activityDidChange() {
        let selectedRows = todayView.tableView.indexPathsForSelectedRows
        todayView.tableView.reloadData()
        print("Hello")
        selectedRows?.forEach({ selectedRow in
            self.todayView.tableView.selectRow(at: selectedRow, animated: false, scrollPosition: .none)
        })
    }
    
}

extension TodayViewController: TodayViewActionHandler {
    func addActivityButtonTapped() {
        let addActivityVC = AddActivityViewController()
        
        addActivityVC.sheetPresentationController?.detents = [.medium()]
        addActivityVC.delegate = self
        
        guard let user else { return }
        addActivityVC.setVC(user: user)
        
        
        present(addActivityVC, animated: true)
    }
}

extension TodayViewController: SendNewActivityDelegate {
    #warning("Remove category from func")
    func sendActivity(activity: Activity, category: Category) {
        
        user.activities.append(activity)
        updateDelegate()
        let selectedRows = todayView.tableView.indexPathsForSelectedRows
        todayView.tableView.reloadData()
        
        selectedRows?.forEach({ selectedRow in
            self.todayView.tableView.selectRow(at: selectedRow, animated: false, scrollPosition: .none)
        })
    }
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.getActivitiesForCategory(user.categories[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as! ActivityCell
        
        let activities = user.getActivitiesForCategory(user.categories[indexPath.section])
        
        cell.set(for: activities[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return user.categories[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return user.categories.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = WColors.background
        let header = view as! UITableViewHeaderFooterView
        var content = header.defaultContentConfiguration()
        content.text = user?.categories[section].name ?? ""
        content.textProperties.color = WColors.green!
        content.textProperties.font = .boldSystemFont(ofSize: 13)
        header.contentConfiguration = content
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activities = user.getActivitiesForCategory(user.categories[indexPath.section])
        
        activities[indexPath.row].startWork()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let activity = user.getActivitiesForCategory(user.categories[indexPath.section])[indexPath.row].finishWork()

        FirebaseUserManager.shared.saveActivity(activity)
    }
        
}
