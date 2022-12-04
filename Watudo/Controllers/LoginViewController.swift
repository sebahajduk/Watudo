//
//  ViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 01/12/2022.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let registerView = RegisterView()
    
    var currentlyLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentlyLogin {
            configureRegisterView()
        } else {
            configureLoginView()
        }
    }
    
    @objc private func buttonTapped() {
        print("Button Tapped, Responder Chain is working.")
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
    
    private func configureLoginView() {
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LoginViewController: LoginViewActionHandler {
    func createAccountTapped(sender: Any?) {
        let registerVC = RegisterViewController()
        navigationController?.present(registerVC, animated: true)
    }
    
    func loginButtonTapped(sender: Any?) {
        print("asd")
    }
}
