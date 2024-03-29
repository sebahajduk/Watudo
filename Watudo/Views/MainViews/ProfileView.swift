//
//  ProfileView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/01/2023.
//

import UIKit

class ProfileView: UIView {

    let nameLabel = WLabel(text: "Sebastian Hajduk", textAlignment: .center, size: 30, weight: .black)

    let firstDivider = DividerView()

    let appearenceModeSwitch = UISwitch()
    let appearenceModeLabel = WLabel(text: "Dark mode", size: 15, weight: .black)

    let secondDivider = DividerView()

    let notificationsLabel = WLabel(text: "NOTIFICATIONS", size: 15, weight: .black)
    let notificationsSwitch = UISwitch()

    let notificationsIntervalLabel = WLabel(text: "NOTIFICATIONS INTERVAL", size: 15, weight: .black)
    let notificationsIntervalTextField = UITextField()
    let notificationsIntervalPicker = UIPickerView()
    let intervalOptions = ["5 min", "10 min", "15 min", "20 min", "30 min"]

    let categoriesDeleteButton = WButton(title: "Delete category", role: .primary)
    let rateUsButton = WButton(title: "Rate us", role: .secondary)
    let signOutButton = WButton(title: "Sign out", role: .secondary)
    let deleteAccount = WButton(title: "Delete account", role: .secondary)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = WColors.background

        configureSettingsViews()
        configureButtons()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSettingsViews() {
        let views: [UIView] = [nameLabel, firstDivider, appearenceModeLabel, appearenceModeSwitch,
                               secondDivider, notificationsLabel,
                               notificationsSwitch, notificationsIntervalLabel, notificationsIntervalTextField]
        addSubviews(views)
        notificationsIntervalPicker.delegate = self
        notificationsIntervalPicker.dataSource = self

        notificationsIntervalTextField.inputView = notificationsIntervalPicker
        notificationsIntervalTextField.placeholder = "30 min"
        notificationsIntervalTextField.textAlignment = .right

        appearenceModeSwitch.addTarget(nil,
                                       action: #selector(ProfileViewActionHandler.switchChanged),
                                       for: .valueChanged)
    }

    private func configureButtons() {
        let views: [UIView] = [categoriesDeleteButton, rateUsButton, signOutButton, deleteAccount]
        addSubviews(views)

        deleteAccount.setTitleColor(WColors.red, for: .normal)
        deleteAccount.layer.borderColor = WColors.red?.cgColor

        signOutButton.addTarget(nil,
                                action: #selector(ProfileViewActionHandler.signOutButtonTapped),
                                for: .touchUpInside)

        categoriesDeleteButton.addTarget(nil,
                                       action: #selector(ProfileViewActionHandler.editCategoryButtonTapped),
                                       for: .touchUpInside)

        deleteAccount.addTarget(nil,
                                action: #selector(ProfileViewActionHandler.deleteAccountTapped),
                                for: .touchUpInside)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),

            appearenceModeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 100),
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

            categoriesDeleteButton.bottomAnchor.constraint(equalTo: rateUsButton.topAnchor, constant: -10),
            categoriesDeleteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoriesDeleteButton.heightAnchor.constraint(equalToConstant: 44),
            categoriesDeleteButton.widthAnchor.constraint(equalToConstant: 290),

            notificationsLabel.topAnchor.constraint(equalTo: appearenceModeLabel.bottomAnchor, constant: 15),
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
            notificationsIntervalTextField.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension ProfileView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intervalOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intervalOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        notificationsIntervalTextField.placeholder = intervalOptions[row]
        notificationsIntervalTextField.resignFirstResponder()

    }
}

@objc protocol ProfileViewActionHandler {
    func switchChanged(mySwitch: UISwitch)
    func signOutButtonTapped(_ sender: UIButton)
    func editCategoryButtonTapped(_ sender: UIButton)
    func deleteAccountTapped(_ sender: UIButton)
}
