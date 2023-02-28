//
//  AddCategoryViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 15/02/2023.
//

import UIKit

class AddCategoryViewController: UIViewController {

    var delegate: SendCategoryDelegate? = nil
    
    let addCategoryView = AddCategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        
        configure()
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

extension AddCategoryViewController: AddCategoryViewActionHandler {
    func nameTFChanged() {
        guard let categoryName = addCategoryView.nameTextField.text else { return }
        
        if categoryName.count > 2 {
            addCategoryView.changeButtonEnableState(to: true)
        } else {
            addCategoryView.changeButtonEnableState(to: false)
        }
    }
    
    func addButtonTapped() {
        guard let categoryName = addCategoryView.nameTextField.text else { return }
        guard let color = addCategoryView.colorPicker.selectedColor?.hexStringFromColor() else { return }
        
        let category = Category(name: categoryName, colorHEX: color)
        
        self.delegate?.sendCategory(category)
        
        self.dismiss(animated: true)
    }
}

protocol SendCategoryDelegate {
    func sendCategory(_ category: Category)
}
