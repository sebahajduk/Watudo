//
//  ViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 01/12/2022.
//

import UIKit
import FacebookLogin

class WelcomeViewController: UIViewController {

    let welcomeView = WelcomeView()
    var currentlyLogged = false
    var backgroundGradient = CAGradientLayer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.isNavigationBarHidden = true
        
        configureWelcomeView()
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

// Buttons tap action handlers
extension WelcomeViewController: LoginViewActionHandler, RegisterViewActionHandler {
      
    // LoginView
    func loginButtonTapped(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)
        
        guard let email = welcomeView.loginView.emailTextField.text else { return }
        guard let password = welcomeView.loginView.passwordTextField.text else { return }
        
        FirebaseManager.shared.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                LocalUserManager.shared.fetchUser { userDataReady in
                    switch userDataReady {
                    case true:
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                    case false:
                        print("FAIL")
                    }
                }
            case .failure(let failure):
                print("There was an error: \(failure.localizedDescription)")
            }
        }
    }
    
    func signInByApple(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)
    }
    
    func signInByGoogle(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)
    }
    
    func signInByFacebook(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)
        
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let result = result, !result.isCancelled else {
                print("User cancelled login")
                return
            }
        }
        
        Profile.loadCurrentProfile { profile, error in
            print("Logged in")
        }
    }
    
    // RegisterView
    func createAccount(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)
        
        guard let email = welcomeView.registerView.emailTextField.text else { return }
        guard let password = welcomeView.registerView.passwordTextField.text else { return }
        
        FirebaseManager.shared.createAccount(email: email, password: password) { result in
            switch result {
            case .success:
                LocalUserManager.shared.fetchUser { userDataReady in
                    switch userDataReady {
                    case true:
                       (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                    case false:
                        print("FAIL")
                    }
                }
                
            case .failure(let failure):
                print("There was an error creating user: \(failure.localizedDescription)")
            }
        }
    }
}
