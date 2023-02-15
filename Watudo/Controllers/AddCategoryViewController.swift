//
//  AddCategoryViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 15/02/2023.
//

import UIKit

class AddCategoryViewController: UIViewController {

    let addCategoryView = AddCategoryView()
    
    var user: LocalUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        configure()
    }
    
    func setVC(user: LocalUser) {
        self.user = user
    }
    
    private func configure() {
        view.addSubview(addCategoryView)
        addCategoryView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addCategoryView.topAnchor.constraint(equalTo: view.topAnchor),
            addCategoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addCategoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addCategoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
