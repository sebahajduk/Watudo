//
//  ViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 01/12/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    let welcomeView = WelcomeView()

    var currentlyLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWelcomeView()
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc private func buttonTapped() {
        print("Button Tapped, Responder Chain is working.")
     }
    
    private func configureWelcomeView() {
        view.addSubview(welcomeView)

        NSLayoutConstraint.activate([
            welcomeView.topAnchor.constraint(equalTo: view.topAnchor),
            welcomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension WelcomeViewController: LoginViewActionHandler {
    func createAccountTapped(sender: Any?) {
        let registerVC = RegisterViewController()
        navigationController?.present(registerVC, animated: true)
    }
    
    func loginButtonTapped(sender: Any?) {
        print("asd")
    }
}
