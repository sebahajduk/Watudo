//
//  ReportsViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit
import JTAppleCalendar

class ReportsViewController: UIViewController {

    let reportsCalendarViewController = ReportsCalendarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WColors.background
        
        self.addChild(reportsCalendarViewController)
        let myCalendar = reportsCalendarViewController.view
        view.addSubview(myCalendar!)
        
        myCalendar?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myCalendar!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myCalendar!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myCalendar!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myCalendar!.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}


