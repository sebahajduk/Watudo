//
//  EditCategoryViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 08/03/2023.
//

import UIKit

class EditCategoryViewController: UIViewController {

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        tableView.backgroundColor = .clear
        configure()
    }

    private func configure() {
        view.addSubviews([tableView])

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EditCategoryCell.self, forCellReuseIdentifier: EditCategoryCell.reuseID)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension EditCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LocalUserManager.shared.getNumberOfCategories()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: EditCategoryCell.reuseID) as? EditCategoryCell
        else { return UITableViewCell() }

        let categories = LocalUserManager.shared.getCategories()
        cell.set(for: categories[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            do {
                try LocalUserManager.shared.deleteCategory(at: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                self.presentAlert(title: "Error", message: error.localizedDescription.description)
            }
        }
    }
}
