//
//  AddCategoryView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 15/02/2023.
//

import UIKit

class AddCategoryView: UIView {
    
    let addCategoryLabel = UILabel()

    let visualEffect = WVisualEffectView(cornerRadius: 8)
    let nameTextField = UITextField()
    
    let colorLabel = UILabel()
    let colorPicker: UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.supportsAlpha = false
        colorWell.selectedColor = UIColor.random()
        return colorWell
    }()
    
    let addButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeButtonEnableState(to isEnabled: Bool) {
        if isEnabled {
            addButton.setTitleColor(WColors.purple, for: .normal)
        } else {
            addButton.setTitleColor(WColors.purple?.withAlphaComponent(0.3), for: .normal)
        }
    }
    
    private func configure() {
        addSubviews([addCategoryLabel, addButton, visualEffect, nameTextField, colorLabel, colorPicker])
        
        nameTextField.placeholder = "Category name"
        nameTextField.addTarget(nil, action: #selector(AddCategoryViewActionHandler.nameTFChanged), for: .editingChanged)
        
        addCategoryLabel.text = "Add category"
        addCategoryLabel.font = UIFont(name: "Panton-BlackCaps", size: 20)
        addCategoryLabel.textColor = WColors.purple
        
        colorLabel.text = "Color"
        
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(WColors.purple, for: .normal)
        addButton.addTarget(nil, action: #selector(AddCategoryViewActionHandler.addButtonTapped), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            
            addCategoryLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            addCategoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addCategoryLabel.heightAnchor.constraint(equalToConstant: 25),
            addCategoryLabel.widthAnchor.constraint(equalToConstant: 150),
            
            visualEffect.topAnchor.constraint(equalTo: addCategoryLabel.bottomAnchor, constant: 20),
            visualEffect.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffect.heightAnchor.constraint(equalToConstant: 120),
            visualEffect.widthAnchor.constraint(equalToConstant: 330),
            
            nameTextField.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            colorLabel.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            colorLabel.widthAnchor.constraint(equalToConstant: 100),
            colorLabel.heightAnchor.constraint(equalToConstant: 40),
            
            colorPicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            colorPicker.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -40),
            colorPicker.widthAnchor.constraint(equalToConstant: 44),
            colorPicker.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

@objc protocol AddCategoryViewActionHandler {
    func addButtonTapped()
    func nameTFChanged()
}
