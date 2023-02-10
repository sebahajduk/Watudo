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
        
        for category in user.categories {
            for activity in category.activities {
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
        
        DispatchQueue.main.async {
            selectedRows?.forEach({ selectedRow in
                self.todayView.tableView.selectRow(at: selectedRow, animated: false, scrollPosition: .none)
            })
        }
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
    func sendActivity(activity: Activity, category: Category) {
        
        guard let index = user?.categories.firstIndex(where: { $0 == category} ) else { return }
        
        user.categories[index].activities.append(activity)
        
        todayView.tableView.reloadData()
    }
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.categories[section].activities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as! ActivityCell
        
        let activity =  user.categories[indexPath.section].activities[indexPath.row]
        
        cell.set(for: activity)
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
        user.categories[indexPath.section].activities[indexPath.row].startWork()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let activity = user.categories[indexPath.section].activities[indexPath.row].finishWork()
        
        FirebaseUserManager.shared.saveActivity(activity)
    }
        
}
