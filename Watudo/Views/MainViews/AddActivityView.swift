//
//  AddActivityView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/01/2023.
//

import UIKit

class AddActivityView: UIView {
    
    let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    
    let nameTextField = UITextField()
    let goalTextField = UITextField()
    
    let divider = DividerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    private func configure() {
        addSubviews([visualEffect, nameTextField, divider ,goalTextField])
        
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        goalTextField.translatesAutoresizingMaskIntoConstraints = false
        
        visualEffect.layer.cornerRadius = 8
        visualEffect.clipsToBounds = true
        
        nameTextField.placeholder = "Name"
        goalTextField.placeholder = "Daily goal in minutes"
    
        NSLayoutConstraint.activate([
            visualEffect.centerYAnchor.constraint(equalTo: centerYAnchor),
            visualEffect.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffect.widthAnchor.constraint(equalToConstant: 330),
            visualEffect.heightAnchor.constraint(equalToConstant: 118),
            
            nameTextField.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            divider.centerYAnchor.constraint(equalTo: visualEffect.centerYAnchor),
            divider.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 30),
            divider.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -30),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            goalTextField.bottomAnchor.constraint(equalTo: visualEffect.bottomAnchor, constant: -10),
            goalTextField.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            goalTextField.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -20),
            goalTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
