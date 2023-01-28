//
//  AddActivityView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/01/2023.
//

import UIKit

class AddActivityView: UIView {
    
    let doneButton = UIButton()
    
    let titleLabel = UILabel()
    
    let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    let nameTextField = UITextField()
    let divider = DividerView()
    let goalTextField = UITextField()
    
    let categoryPicker = UIPickerView()
    
    let paidSwitch = UISwitch()
    
    let visualEffectSmall = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    let moneyPerHourTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    private func configure() {
        let views: [UIView] = [doneButton, titleLabel, visualEffect, nameTextField, divider, goalTextField, paidSwitch, visualEffectSmall, moneyPerHourTextField, categoryPicker]
        
        addSubviews(views)
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(WColors.purple, for: .normal)
        doneButton.addTarget(nil, action: #selector(AddActivityViewActionHandler.doneButtonTapped), for: .touchUpInside)
        
        titleLabel.text = "Add activity"
        titleLabel.font = UIFont(name: "Panton-BlackCaps", size: 20)
        titleLabel.textColor = WColors.purple
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        moneyPerHourTextField.isEnabled = false
        moneyPerHourTextField.placeholder = "Paid?"
        
        paidSwitch.addTarget(self, action: #selector(switchTapped), for: .touchUpInside)
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        visualEffect.layer.cornerRadius = 8
        visualEffect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        visualEffect.clipsToBounds = true
        
        visualEffectSmall.layer.cornerRadius = 8
        visualEffectSmall.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        visualEffectSmall.clipsToBounds = true
        
        nameTextField.placeholder = "Name"
        goalTextField.placeholder = "Daily goal in minutes"
    
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 44),
            doneButton.widthAnchor.constraint(equalToConstant: 44),
            
            titleLabel.topAnchor.constraint(equalTo: doneButton.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            
            visualEffect.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            visualEffect.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffect.heightAnchor.constraint(equalToConstant: 118),
            visualEffect.widthAnchor.constraint(equalToConstant: 330),
            
            nameTextField.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            divider.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 30),
            divider.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -30),
            divider.centerYAnchor.constraint(equalTo: visualEffect.centerYAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            goalTextField.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            goalTextField.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -20),
            goalTextField.bottomAnchor.constraint(equalTo: visualEffect.bottomAnchor, constant: -10),
            goalTextField.heightAnchor.constraint(equalToConstant: 44),
            
            visualEffectSmall.topAnchor.constraint(equalTo: visualEffect.bottomAnchor),
            visualEffectSmall.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor),
            visualEffectSmall.heightAnchor.constraint(equalToConstant: 64),
            visualEffectSmall.widthAnchor.constraint(equalToConstant: 250),
            
            paidSwitch.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor),
            paidSwitch.centerYAnchor.constraint(equalTo: moneyPerHourTextField.centerYAnchor),
            
            moneyPerHourTextField.topAnchor.constraint(equalTo: visualEffectSmall.topAnchor, constant: 10),
            moneyPerHourTextField.leadingAnchor.constraint(equalTo: visualEffectSmall.leadingAnchor, constant: 10),
            moneyPerHourTextField.trailingAnchor.constraint(equalTo: visualEffectSmall.trailingAnchor, constant: -10),
            moneyPerHourTextField.heightAnchor.constraint(equalToConstant: 44),
            
            categoryPicker.topAnchor.constraint(equalTo: moneyPerHourTextField.bottomAnchor, constant: 10),
            categoryPicker.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryPicker.heightAnchor.constraint(equalToConstant: 150),
            categoryPicker.widthAnchor.constraint(equalToConstant: 330),
        ])
    }
    
    @objc func switchTapped() {
        if paidSwitch.isOn {
            moneyPerHourTextField.placeholder = "Money per hour"
            moneyPerHourTextField.isEnabled = true
        } else {
            moneyPerHourTextField.placeholder = "Paid?"
            moneyPerHourTextField.isEnabled = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AddActivityView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Category"
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}

@objc protocol AddActivityViewActionHandler {
    func doneButtonTapped()
}
