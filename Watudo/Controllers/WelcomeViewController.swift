//
//  ViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 01/12/2022.
//

import UIKit
import AuthenticationServices

class WelcomeViewController: UIViewController {

    let welcomeView = WelcomeView()
    var currentlyLogged = false
    var backgroundGradient = CAGradientLayer()

    var currentNonce: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.hidesBarsOnSwipe = true
        navigationController?.isNavigationBarHidden = true

        configureWelcomeView()
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

        WLoginManager.signIn(email: email, password: password) { error in
            guard let error = error else { return }
            self.presentAlert(error)
        }
    }

    func signInByApple(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)

        WLoginManager().signInApple(self, currentNonce: &currentNonce)
    }

    func signInByGoogle(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)

        WLoginManager.signInGoogle(viewController: self) { error in
            guard let error = error else { return }

            self.presentAlert(error)
        }
    }

    func signInByFacebook(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)

        WLoginManager.signInFacebook { error in
            guard let error = error else { return }

            self.presentAlert(error)
        }
    }

    func resetPasswordButtonTapped(sender: UIButton) {
        guard !welcomeView.loginView.emailTextField.text!.isEmpty else {
            self.presentAlert(WError.emptyEmailPasswordReset)
            return
        }
        let email = welcomeView.loginView.emailTextField.text!

        FirebaseManager.shared.resetPassword(email: email) { err in
           self.presentAlert(err)
        }
    }

    // RegisterView
    func createAccount(sender: UIButton) {
        WAnimations.buttonTapAnimation(sender)

        guard let email = welcomeView.registerView.emailTextField.text else { return }
        guard let password = welcomeView.registerView.passwordTextField.text else { return }
        guard let name = welcomeView.registerView.nicknameTextField.text else { return }

        WLoginManager.createAccount(email: email, password: password, name: name) { error in
            guard let error = error else { return }

            self.presentAlert(error)
        }
    }

}

// UITextFields listeners
extension WelcomeViewController: WelcomeViewTFListener {
    func textFieldDidChange(_ sender: UITextField) {
        let loginView = welcomeView.loginView
        let loginViewTFTags = [0, 1]
        let registerView = welcomeView.registerView

        if loginViewTFTags.contains(sender.tag) {
            if isLoginDataValid(email: loginView.emailTextField.text ?? "",
                                password: loginView.passwordTextField.text ?? "") {
                loginView.loginButton.isEnabled = true
            } else {
                loginView.loginButton.isEnabled = false
            }
        } else {
            if isRegisterDataValid(nickname: registerView.nicknameTextField.text ?? "",
                                   email: registerView.emailTextField.text ?? "",
                                   password: registerView.passwordTextField.text ?? "",
                                   repeatedPass: registerView.repeatPasswordTextField.text ?? "") {
                registerView.createAccountButton.isEnabled = true
            } else {
                registerView.createAccountButton.isEnabled = false
            }
        }
    }

    private func isLoginDataValid(email: String, password: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        let isEmailValid = emailPredicate.evaluate(with: email)
        let isPasswordValid = password.count > 5

        if isEmailValid && isPasswordValid {
            return true
        }

        return false
    }

    private func isRegisterDataValid(nickname: String,
                                     email: String,
                                     password: String,
                                     repeatedPass: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        let isNicknameValid = nickname.count > 2
        let isEmailValid = emailPredicate.evaluate(with: email)
        let isPasswordValid = password.count > 5
        let isRepeatedPassValid = repeatedPass == password

        if isNicknameValid && isEmailValid && isPasswordValid && isRepeatedPassValid {
            return true
        }

        return false
    }
}

extension WelcomeViewController: ASAuthorizationControllerDelegate,
                                    ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        WLoginManager.initializeCredentials(with: authorization, currentNonce: currentNonce) { error in
            guard let error = error else { return }
            self.presentAlert(error)
        }
    }
}
