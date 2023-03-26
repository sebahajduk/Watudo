//
//  TodayViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit

class TodayViewController: UIViewController, ActivityDelegate {

    var todayView = TodayView()

    var timer: Timer?

    var selectedRows: [IndexPath] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        todayView.tableView.reloadData()
        prepareChartsData()

        selectedRows.forEach({ selectedRow in
            self.todayView.tableView.selectRow(at: selectedRow, animated: false, scrollPosition: .none)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background!

        todayView.tableView.dataSource = self
        todayView.tableView.delegate = self
        todayView.tableView.allowsMultipleSelection = true
        updateDelegate()

        prepareChartsData()

        navigationController?.isNavigationBarHidden = true

        view.addSubview(todayView)
        NSLayoutConstraint.activate([
            todayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        fetchQuote()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        selectedRows = todayView.tableView.indexPathsForSelectedRows ?? []
    }

    private func prepareChartsData() {
        var dates: [String] = []
        var weekdays: [String] = []
        var timeHistory: [Double] = []
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.dateFormat = "EEE"

        for i in 0...6 {
            guard let day = Calendar.current.date(byAdding: .day, value: -i, to: Date()) else { return }
            let dateString = day.dateToStringYMD()
            dates.append(dateString)
            weekdays.append(formatter.string(from: day).uppercased())
        }

        FirebaseManager.shared.getLastWeekHistory { result in
            switch result {
            case .success(let lastWeekHistory):
                for day in dates {
                    if lastWeekHistory[day] != nil {
                        var timeSpent: Double = 0
                        for activity in lastWeekHistory[day]! {
                            timeSpent += activity.timeSpent
                        }
                        timeHistory.append(timeSpent)
                    } else {
                        timeHistory.append(0)
                    }
                }

                self.todayView.chartView.setData(forTimes: timeHistory, forDays: weekdays.reversed())

            case .failure(let failure):
                print(failure)
            }
        }
    }

    private func updateDelegate() {
        let activities = LocalUserManager.shared.getActivities()

        for activity in activities {
            activity.delegate = self
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

        present(addActivityVC, animated: true)
    }

    func addCategoryButtonTapped() {
        let addCategoryVC = AddCategoryViewController()

        addCategoryVC.sheetPresentationController?.detents = [.custom(resolver: { (_) in
            return 300
        })]
        addCategoryVC.delegate = self

        present(addCategoryVC, animated: true)
    }
}

extension TodayViewController: SendNewActivityDelegate, SendCategoryDelegate {
    func sendCategory(_ category: Category) {
        LocalUserManager.shared.addCategory(category)
        FirebaseManager.shared.add(category)

        let selectedRows = todayView.tableView.indexPathsForSelectedRows
        todayView.tableView.reloadData()

        selectedRows?.forEach({ selectedRow in
            self.todayView.tableView.selectRow(at: selectedRow, animated: false, scrollPosition: .none)
        })
    }

    func sendActivity(activity: Activity) {
        LocalUserManager.shared.addActivity(activity)
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
        LocalUserManager.shared.getActivitiesForCategory(at: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseID) as? ActivityCell
        else { return UITableViewCell() }

        let activities = LocalUserManager.shared.getActivitiesForCategory(at: indexPath.section)

        cell.set(for: activities[indexPath.row], style: .activity)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LocalUserManager.shared.getCategory(for: section).name
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return LocalUserManager.shared.getNumberOfCategories()
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let category = LocalUserManager.shared.getCategory(for: section)
        let sectionColor = UIColor().colorWithHexString(hexString: category.colorHEX)
        view.tintColor = WColors.background
        guard
            let header = view as? UITableViewHeaderFooterView
        else { return }

        var content = header.defaultContentConfiguration()
        content.text = category.name
        content.textProperties.color = sectionColor
        content.textProperties.font = .boldSystemFont(ofSize: 13)
        header.contentConfiguration = content
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LocalUserManager.shared.startWork(at: indexPath)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        LocalUserManager.shared.finishWork(at: indexPath)
        prepareChartsData()
    }

    /// Drag deleting row
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           do {
               try LocalUserManager.shared.removeActivity(at: indexPath)
               tableView.deleteRows(at: [indexPath], with: .automatic)
           } catch {
               self.presentAlert(title: "Error", message: error.localizedDescription)
           }
       }
    }

    /// If cell is actively measuring time stop the timer.
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!

        if cell.isSelected {
            LocalUserManager.shared.finishWork(at: indexPath)
        }
    }
}
