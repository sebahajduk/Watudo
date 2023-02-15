//
//  AddCategoryView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 15/02/2023.
//

import UIKit

class AddCategoryView: UIView {

    let visualEffect = WVisualEffectView(cornerRadius: 8)
    let nameTextField = UITextField()
    
    let colorLabel = UILabel()
    let colorPicker: UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.supportsAlpha = false
        
        return colorWell
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews([visualEffect, nameTextField, colorLabel, colorPicker])
        
        nameTextField.placeholder = "Category name"
        colorLabel.text = "Color"
        
        NSLayoutConstraint.activate([
            visualEffect.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
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
