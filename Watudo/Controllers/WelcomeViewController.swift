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
    func loginButtonTapped(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)
        
        print("Hello world")
    }
    
    func signInByApple(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)
    }
    
    func signInByGoogle(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)
    }
    
    func signInByFacebook(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)
    }
}
