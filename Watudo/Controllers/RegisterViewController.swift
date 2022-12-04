//
//  RegisterViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 04/12/2022.
//

import UIKit

class RegisterViewController: UIViewController {

    let registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRegisterView()
    }
    
    private func configureRegisterView() {
        view.addSubview(registerView)
        
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.topAnchor),
            registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
