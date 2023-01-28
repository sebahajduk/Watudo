//
//  ProfileView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/01/2023.
//

import UIKit

class ProfileView: UIView {
    
    let profileImage = UIImageView()
    let nameLabel = WLabel(text: "Michael Myers", textAlignment: .center, size: 20, weight: .black)
    
    let firstDivider = DividerView()
    
    let appearenceModeSwitch = UISwitch()
    let appearenceModeLabel = WLabel(text: "Dark mode", size: 15, weight: .black)
    
    let timeZoneLabel = WLabel(text: "Time zone", size: 15, weight: .black)
    let timeZoneTextField = UITextField()
    let timeZonePicker = UIPickerView()
    let timeZoneOptions = ["12h","24h"]
    
    let secondDivider = DividerView()
    
    let notificationsLabel = WLabel(text: "NOTIFICATIONS", size: 15, weight: .black)
    let notificationsSwitch = UISwitch()
    
    let notificationsIntervalLabel = WLabel(text: "NOTIFICATIONS interval", size: 15, weight: .black)
    let notificationsIntervalTextField = UITextField()
    let notificationsIntervalPicker = UIPickerView()
    let intervalOptions = ["5 min", "10 min", "15 min", "20 min", "30 min"]
    
    let categoriesEditButton = WButton(title: "Edit categories", role: .primary)
    let rateUsButton = WButton(title: "Rate us", role: .secondary)
    let signOutButton = WButton(title: "Sign out", role: .secondary)
    let deleteAccount = WButton(title: "Delete account", role: .secondary)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = WColors.background
        
        
        configureUserInfo()
        configureSettingsViews()
        configureButtons()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUserInfo() {
        let views: [UIView] = [profileImage, nameLabel]
        addSubviews(views)
        
        profileImage.image = UIImage(systemName: "camera")
        profileImage.contentMode = .scaleAspectFit
        profileImage.backgroundColor = WColors.foreground?.withAlphaComponent(0.05)
        profileImage.tintColor = WColors.purple!.withAlphaComponent(0.5)
        profileImage.addCornerRadius(radius: 50)
        profileImage.clipsToBounds = true
        
    }
    
    private func configureSettingsViews() {
        let views: [UIView] = [firstDivider, appearenceModeLabel, appearenceModeSwitch, secondDivider, timeZoneLabel, timeZoneTextField, notificationsLabel, notificationsSwitch, notificationsIntervalLabel, notificationsIntervalTextField]
        addSubviews(views)
        
        timeZonePicker.tag = 0
        notificationsIntervalPicker.tag = 1
        
        timeZonePicker.delegate = self
        timeZonePicker.dataSource = self
        
        notificationsIntervalPicker.delegate = self
        notificationsIntervalPicker.dataSource = self
        
        timeZoneTextField.inputView = timeZonePicker
        timeZoneTextField.placeholder = "24H"
        timeZoneTextField.textAlignment = .right
        
        notificationsIntervalTextField.inputView = notificationsIntervalPicker
        notificationsIntervalTextField.placeholder = "30 min"
        notificationsIntervalTextField.textAlignment = .right
    }
    
    private func configureButtons() {
        let views: [UIView] = [categoriesEditButton, rateUsButton, signOutButton, deleteAccount]
        addSubviews(views)
        
        deleteAccount.setTitleColor(WColors.red, for: .normal)
        deleteAccount.layer.borderColor = WColors.red?.cgColor
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            
            appearenceModeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 100),
            appearenceModeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            appearenceModeLabel.heightAnchor.constraint(equalToConstant: 30),
            appearenceModeLabel.widthAnchor.constraint(equalToConstant: 200),
            
            appearenceModeSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            appearenceModeSwitch.centerYAnchor.constraint(equalTo: appearenceModeLabel.centerYAnchor),
            
            deleteAccount.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            deleteAccount.centerXAnchor.constraint(equalTo: centerXAnchor),
            deleteAccount.heightAnchor.constraint(equalToConstant: 44),
            deleteAccount.widthAnchor.constraint(equalToConstant: 290),
            
            signOutButton.bottomAnchor.constraint(equalTo: deleteAccount.topAnchor, constant: -10),
            signOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 44),
            signOutButton.widthAnchor.constraint(equalToConstant: 290),
            
            rateUsButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -10),
            rateUsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            rateUsButton.heightAnchor.constraint(equalToConstant: 44),
            rateUsButton.widthAnchor.constraint(equalToConstant: 290),
            
            categoriesEditButton.bottomAnchor.constraint(equalTo: rateUsButton.topAnchor, constant: -10),
            categoriesEditButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoriesEditButton.heightAnchor.constraint(equalToConstant: 44),
            categoriesEditButton.widthAnchor.constraint(equalToConstant: 290),
            
            timeZoneLabel.topAnchor.constraint(equalTo: appearenceModeLabel.bottomAnchor, constant: 15),
            timeZoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeZoneLabel.heightAnchor.constraint(equalToConstant: 30),
            timeZoneLabel.widthAnchor.constraint(equalToConstant: 200),
            
            timeZoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            timeZoneTextField.centerYAnchor.constraint(equalTo: timeZoneLabel.centerYAnchor),
            timeZoneTextField.heightAnchor.constraint(equalToConstant: 30),
            timeZoneTextField.widthAnchor.constraint(equalToConstant: 50),
            
            notificationsLabel.topAnchor.constraint(equalTo: timeZoneLabel.bottomAnchor, constant: 15),
            notificationsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            notificationsLabel.heightAnchor.constraint(equalToConstant: 30),
            notificationsLabel.widthAnchor.constraint(equalToConstant: 200),
            
            notificationsSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            notificationsSwitch.centerYAnchor.constraint(equalTo: notificationsLabel.centerYAnchor),
            
            notificationsIntervalLabel.topAnchor.constraint(equalTo: notificationsLabel.bottomAnchor, constant: 15),
            notificationsIntervalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            notificationsIntervalLabel.heightAnchor.constraint(equalToConstant: 30),
            notificationsIntervalLabel.widthAnchor.constraint(equalToConstant: 200),
            
            notificationsIntervalTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            notificationsIntervalTextField.centerYAnchor.constraint(equalTo: notificationsIntervalLabel.centerYAnchor),
            notificationsIntervalTextField.heightAnchor.constraint(equalToConstant: 30),
            notificationsIntervalTextField.widthAnchor.constraint(equalToConstant: 100),
        ])
        
    }
    
}

extension ProfileView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title: String = ""
        
        if pickerView.tag == 0 {
            title = timeZoneOptions[row]
        } else {
            title = intervalOptions[row]
        }
        
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return timeZoneOptions.count
        } else {
            return intervalOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            timeZoneTextField.placeholder = timeZoneOptions[row]
            timeZoneTextField.resignFirstResponder()
        } else {
            notificationsIntervalTextField.placeholder = intervalOptions[row]
            notificationsIntervalTextField.resignFirstResponder()
        }
    }
}
