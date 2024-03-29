//
//  LoginView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/12/2022.
//

import UIKit
import FacebookLogin
import AuthenticationServices

class LoginView: UIView, UITextFieldDelegate {

    let greetingLabel = UILabel()
    let greetingDescriptionLabel = UILabel()

    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let visualEffectView = WVisualEffectView()

    let emailImage = UIImageView(image: UIImage(systemName: "at"))
    let passwordImage = UIImageView(image: UIImage(systemName: "lock.fill"))

    let forgetPasswordButton = UIButton()

    let firstTimeHereLabel = UILabel()

    let divider = DividerView()
    let signInDivider = DividerView()

    let loginButton = WButton(title: "Sign in", role: .primary)
    let googleButton = WButton(image: UIImage(named: "google")!, role: .secondary)
    let facebookButton = WButton(image: UIImage(named: "facebook")!, role: .secondary)
    let appleButton = WButton(image: UIImage(named: "apple")!, role: .secondary)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        configureUI()

        emailTextField.addTarget(nil,
                                 action: #selector(WelcomeViewTFListener.textFieldDidChange),
                                 for: .editingChanged)

        passwordTextField.addTarget(nil,
                                    action: #selector(WelcomeViewTFListener.textFieldDidChange),
                                    for: .editingChanged)

        loginButton.isEnabled = false
    }

    private func configureUI() {
        configureLayoutElements()
        configureTextFields()
        configureButtons()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Buttons tap action handler - called by Responder Chain in WelcomeViewController.
@objc protocol LoginViewActionHandler {
    func loginButtonTapped(sender: UIButton)
    func signInByFacebook(sender: UIButton)
    func signInByApple(sender: UIButton)
    func signInByGoogle(sender: UIButton)
    func resetPasswordButtonTapped(sender: UIButton)
}

// UI configure functions
extension LoginView {

    private func configureTextFields() {
        addSubviews([emailTextField, passwordTextField, emailImage, passwordImage])

        emailTextField.text = "Test9@gmail.com"
        passwordTextField.text = "Test99"

        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true

        emailTextField.delegate = self
        passwordTextField.delegate = self

        emailTextField.tag = 0
        passwordTextField.tag = 1

        emailImage.tintColor = .gray.withAlphaComponent(0.7)
        emailImage.contentMode = .scaleAspectFit

        passwordImage.tintColor = .gray.withAlphaComponent(0.7)
        passwordImage.contentMode = .scaleAspectFit

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        emailImage.translatesAutoresizingMaskIntoConstraints = false
        passwordImage.translatesAutoresizingMaskIntoConstraints = false
   }

    private func configureLayoutElements() {
        addSubviews([greetingLabel, greetingDescriptionLabel, visualEffectView,
                     divider, signInDivider, firstTimeHereLabel])

        greetingLabel.text = "Hi."
        greetingLabel.textColor = WColors.purple
        greetingLabel.font = UIFont(name: "Panton-BlackCaps", size: 40)
        greetingLabel.textAlignment = .center
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false

        greetingDescriptionLabel.text = "Good to see you again"
        greetingDescriptionLabel.textColor = WColors.purple
        greetingDescriptionLabel.font = UIFont(name: "Panton-LightCaps", size: 20)
        greetingDescriptionLabel.textAlignment = .center
        greetingDescriptionLabel.adjustsFontSizeToFitWidth = true
        greetingDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        firstTimeHereLabel.text = "Swipe up to create account"
        firstTimeHereLabel.textColor = WColors.purple
        firstTimeHereLabel.textAlignment = .center
        firstTimeHereLabel.font = .systemFont(ofSize: 15)
        firstTimeHereLabel.translatesAutoresizingMaskIntoConstraints = false

        visualEffectView.clipsToBounds = true
        visualEffectView.layer.cornerRadius = 8
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false

        signInDivider.backgroundColor = WColors.purple?.withAlphaComponent(0.2)

    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

    private func configureButtons() {
        let isLightMode = traitCollection.userInterfaceStyle == .light ? true : false
        addSubviews([forgetPasswordButton, loginButton, appleButton, facebookButton, googleButton])

        loginButton.addTarget(nil, action: #selector(LoginViewActionHandler.loginButtonTapped), for: .touchUpInside)
        appleButton.addTarget(nil, action: #selector(LoginViewActionHandler.signInByApple), for: .touchUpInside)
        facebookButton.addTarget(nil, action: #selector(LoginViewActionHandler.signInByFacebook), for: .touchUpInside)
        googleButton.addTarget(nil, action: #selector(LoginViewActionHandler.signInByGoogle), for: .touchUpInside)

        forgetPasswordButton.addTarget(nil,
                                       action: #selector(LoginViewActionHandler.resetPasswordButtonTapped),
                                       for: .touchUpInside)

        if isLightMode {
            loginButton.addShadowToView(shadowColor: WColors.purple!,
                                        offset: CGSize(width: 0, height: 20),
                                        shadowRadius: 30,
                                        shadowOpacity: 0.5,
                                        cornerRadius: 10)
        }

        forgetPasswordButton.setTitle("Recovery password", for: .normal)
        forgetPasswordButton.setTitleColor(.systemGray2, for: .normal)
        forgetPasswordButton.titleLabel?.adjustsFontSizeToFitWidth = true
        forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
    }

    // swiftlint:disable function_body_length
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: topAnchor, constant: -10),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            greetingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            greetingLabel.heightAnchor.constraint(equalToConstant: 50),

            greetingDescriptionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
            greetingDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            greetingDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            greetingDescriptionLabel.heightAnchor.constraint(equalToConstant: 30),

            visualEffectView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: Dimension.loginViewVisualEffectViewTopAnchor),
            visualEffectView.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffectView.heightAnchor.constraint(equalToConstant: 105),
            visualEffectView.widthAnchor.constraint(equalToConstant: 330),

            forgetPasswordButton.topAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: 10),
            forgetPasswordButton.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor),
            forgetPasswordButton.heightAnchor.constraint(equalToConstant: 20),
            forgetPasswordButton.widthAnchor.constraint(equalToConstant: 100),

            loginButton.topAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: 50),
            loginButton.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.widthAnchor.constraint(equalToConstant: 290),

            emailTextField.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 5),
            emailTextField.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.widthAnchor.constraint(equalToConstant: 290),

            emailImage.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            emailImage.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            emailImage.heightAnchor.constraint(equalToConstant: 20),
            emailImage.widthAnchor.constraint(equalToConstant: 20),

            passwordTextField.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -5),
            passwordTextField.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.widthAnchor.constraint(equalToConstant: 290),

            passwordImage.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordImage.heightAnchor.constraint(equalToConstant: 20),
            passwordImage.widthAnchor.constraint(equalToConstant: 20),

            divider.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            divider.centerYAnchor.constraint(equalTo: visualEffectView.centerYAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.widthAnchor.constraint(equalToConstant: 270),

            firstTimeHereLabel.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 50),
            firstTimeHereLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstTimeHereLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            firstTimeHereLabel.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),

            signInDivider.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50),
            signInDivider.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInDivider.heightAnchor.constraint(equalToConstant: 1),
            signInDivider.widthAnchor.constraint(equalToConstant: 280),

            appleButton.topAnchor.constraint(equalTo: signInDivider.bottomAnchor, constant: 50),
            appleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            appleButton.heightAnchor.constraint(equalToConstant: 50),
            appleButton.widthAnchor.constraint(equalToConstant: 80),

            facebookButton.topAnchor.constraint(equalTo: signInDivider.bottomAnchor, constant: 50),
            facebookButton.trailingAnchor.constraint(equalTo: appleButton.leadingAnchor, constant: -10),
            facebookButton.heightAnchor.constraint(equalToConstant: 50),
            facebookButton.widthAnchor.constraint(equalToConstant: 80),

            googleButton.topAnchor.constraint(equalTo: signInDivider.bottomAnchor, constant: 50),
            googleButton.leadingAnchor.constraint(equalTo: appleButton.trailingAnchor, constant: 10),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            googleButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    // swiftlint:enable function_body_length
}

// Updates view depending on user interface style changes.
extension LoginView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        resetViewsForNewInterfaceStyle(previousTraitCollection)
    }

    func resetViewsForNewInterfaceStyle(_ previousTraitCollection: UITraitCollection?) {
        switch previousTraitCollection?.userInterfaceStyle {
            // Change from light mode to dark mode.
        case .light:
            loginButton.addShadowToView(shadowColor: .clear,
                                        offset: CGSize(width: 0, height: 20),
                                        shadowRadius: 30,
                                        shadowOpacity: 0.5,
                                        cornerRadius: 10)

            // Change from dark mode to light mode.
        case .dark:
            loginButton.addShadowToView(shadowColor: WColors.purple!,
                                        offset: CGSize(width: 0, height: 20),
                                        shadowRadius: 30,
                                        shadowOpacity: 0.7,
                                        cornerRadius: 10)

        default:
            // Do nothing, view shouldn't change.
            print("We have no information about user interface style")
        }
    }
}
