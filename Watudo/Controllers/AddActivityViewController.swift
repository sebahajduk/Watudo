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
    func doneButtonTapped() {
        let activity = Activity(name: addActivityView.nameTextField.text ?? "")
        self.delegate?.sendActivity(activity: activity)
        
        self.dismiss(animated: true)
    }
}
protocol SendNewActivityDelegate {
    func sendActivity(activity: Activity)
}
