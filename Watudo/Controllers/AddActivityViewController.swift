//
//  AddActivityViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/01/2023.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    let addActivityView = AddActivityView()
    
    var delegate: SendNewActivityDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        
        addActivityView.categoryPicker.delegate = self
        addActivityView.categoryPicker.dataSource = self
        
        configure()
    }
    
    private func configure() {
        view.addSubview(addActivityView)
        
        NSLayoutConstraint.activate([
            addActivityView.topAnchor.constraint(equalTo: view.topAnchor),
            addActivityView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addActivityView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addActivityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension AddActivityViewController: AddActivityViewActionHandler {
    func nameTFchanged() {
        guard let activityName = addActivityView.nameTextField.text else { return }
        
        if activityName.count > 2 {
            addActivityView.changeButtonEnableState(to: true)
        } else {
            addActivityView.changeButtonEnableState(to: false)
        }
    }
    
    func doneButtonTapped() {
        let pickerViewSelectedRow = addActivityView.categoryPicker.selectedRow(inComponent: 0)
        let activityName = addActivityView.nameTextField.text!
        let activityCategory = LocalUserManager.shared.getCategory(for: pickerViewSelectedRow)
        
        let activity = Activity(name: activityName, category: activityCategory)
        
        if LocalUserManager.shared.getActivities().contains(where: { $0.name == activity.name }) {
            self.presentAlert(title: "Error", message: "This name is taken. Please choose another one.")
            return
        }
        
        self.delegate?.sendActivity(activity: activity)
        self.dismiss(animated: true)
    }
}

extension AddActivityViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        LocalUserManager.shared.getNumberOfCategories()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        LocalUserManager.shared.getCategory(for: row).name
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}

protocol SendNewActivityDelegate {
    func sendActivity(activity: Activity)
}
