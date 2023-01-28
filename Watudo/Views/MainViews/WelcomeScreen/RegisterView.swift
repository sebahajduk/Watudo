//
//  RegisterView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 04/12/2022.
//

import UIKit

class RegisterView: UIView, UITextFieldDelegate {
    
    let greetingLabel = UILabel()
    let greetingDescriptionLabel = UILabel()

    let nicknameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let repeatPasswordTextField = UITextField()
    let materialBackground = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    
    let firstDivider = DividerView()
    let secondDivider = DividerView()
    let thirdDivider = DividerView()
    
    let nicknameImage = UIImageView(image: UIImage(systemName: "person.fill"))
    let emailImage = UIImageView(image: UIImage(systemName: "at"))
    let passwordImage = UIImageView(image: UIImage(systemName: "lock.fill"))
    let passwordRepeatImage = UIImageView(image: UIImage(systemName: "lock.rotation"))
    
    let createAccountButton = WButton(title: "Create account", role: .primary)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
    }
    
    private func configureUI() {
        configureLayoutElements()
        configureTextFields()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

@objc protocol RegisterViewActionHandler {
    func createAccount(sender: UIButton)
}

// UI configure functions.
extension RegisterView {
    
    private func configureTextFields() {
        let images: [UIImageView] = [nicknameImage, emailImage, passwordImage, passwordRepeatImage]
        let textFields: [UITextField] = [nicknameTextField, emailTextField, passwordTextField, repeatPasswordTextField]
        
        addSubviews(images)
        addSubviews(textFields)
        
        nicknameTextField.placeholder = "Nickname"
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        repeatPasswordTextField.placeholder = "Repeat password"
        
        passwordTextField.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true
        var tag = 0
        for textField in textFields {
            textField.delegate = self
            textField.tag = tag
            tag += 1
            textField.translatesAutoresizingMaskIntoConstraints = false
        }
        
        for image in images {
            image.tintColor = .gray.withAlphaComponent(0.7)
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private func configureLayoutElements() {
        let isLightMode = traitCollection.userInterfaceStyle == .light ? true : false
        addSubviews([greetingLabel, greetingDescriptionLabel, materialBackground, firstDivider, secondDivider, thirdDivider, createAccountButton])
        
        greetingLabel.text = "Hello there."
        greetingLabel.textColor = WColors.purple
        greetingLabel.font = UIFont(name: "Panton-BlackCaps", size: 40)
        greetingLabel.textAlignment = .center
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        greetingDescriptionLabel.text = "Create your account\nStart tracking your activities"
        greetingDescriptionLabel.textColor = WColors.purple
        greetingDescriptionLabel.font = UIFont(name: "Panton-LightCaps", size: 20)
        greetingDescriptionLabel.textAlignment = .center
        greetingDescriptionLabel.numberOfLines = 0
        greetingDescriptionLabel.adjustsFontSizeToFitWidth = true
        greetingDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        materialBackground.layer.cornerRadius = 8
        materialBackground.clipsToBounds = true
        materialBackground.translatesAutoresizingMaskIntoConstraints = false
        
        createAccountButton.addTarget(nil, action: #selector(RegisterViewActionHandler.createAccount), for: .touchUpInside)
        
        if isLightMode {
            createAccountButton.addShadowToView(shadowColor: WColors.purple!, offset: CGSize(width: 0, height: 20), shadowRadius: 30, shadowOpacity: 0.5, cornerRadius: 10)
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            greetingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            greetingLabel.heightAnchor.constraint(equalToConstant: 85),
            
            greetingDescriptionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
            greetingDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            greetingDescriptionLabel.heightAnchor.constraint(equalToConstant: 60),
            greetingDescriptionLabel.widthAnchor.constraint(equalToConstant: 290),
            
            materialBackground.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 160),
            materialBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            materialBackground.heightAnchor.constraint(equalToConstant: 189),
            materialBackground.widthAnchor.constraint(equalToConstant: 330),
            
            nicknameTextField.topAnchor.constraint(equalTo: materialBackground.topAnchor, constant: 5),
            nicknameTextField.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 44),
            nicknameTextField.widthAnchor.constraint(equalToConstant: 290),
            
            nicknameImage.trailingAnchor.constraint(equalTo: nicknameTextField.trailingAnchor),
            nicknameImage.centerYAnchor.constraint(equalTo: nicknameTextField.centerYAnchor),
            nicknameImage.heightAnchor.constraint(equalToConstant: 20),
            nicknameImage.widthAnchor.constraint(equalToConstant: 20),
            
            firstDivider.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor),
            firstDivider.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            firstDivider.widthAnchor.constraint(equalToConstant: 270),
            
            emailTextField.topAnchor.constraint(equalTo: firstDivider.bottomAnchor),
            emailTextField.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.widthAnchor.constraint(equalToConstant: 290),
            
            emailImage.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            emailImage.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            emailImage.heightAnchor.constraint(equalToConstant: 20),
            emailImage.widthAnchor.constraint(equalToConstant: 20),
            
            secondDivider.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            secondDivider.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            secondDivider.widthAnchor.constraint(equalToConstant: 270),
            
            passwordTextField.topAnchor.constraint(equalTo: secondDivider.bottomAnchor),
            passwordTextField.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.widthAnchor.constraint(equalToConstant: 290),
            
            passwordImage.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            passwordImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordImage.heightAnchor.constraint(equalToConstant: 20),
            passwordImage.widthAnchor.constraint(equalToConstant: 20),
            
            thirdDivider.widthAnchor.constraint(equalToConstant: 270),
            thirdDivider.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            thirdDivider.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            
            repeatPasswordTextField.bottomAnchor.constraint(equalTo: materialBackground.bottomAnchor, constant: -6),
            repeatPasswordTextField.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 44),
            repeatPasswordTextField.widthAnchor.constraint(equalToConstant: 290),
            
            passwordRepeatImage.trailingAnchor.constraint(equalTo: repeatPasswordTextField.trailingAnchor),
            passwordRepeatImage.centerYAnchor.constraint(equalTo: repeatPasswordTextField.centerYAnchor),
            passwordRepeatImage.heightAnchor.constraint(equalToConstant: 20),
            passwordRepeatImage.widthAnchor.constraint(equalToConstant: 20),
            
            createAccountButton.topAnchor.constraint(equalTo: materialBackground.bottomAnchor, constant: 20),
            createAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createAccountButton.heightAnchor.constraint(equalToConstant: 44),
            createAccountButton.widthAnchor.constraint(equalToConstant: 290)
        ])
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.endEditing(true)
        }
        
        return true
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

extension RegisterView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        resetViewsForNewInterfaceStyle(previousTraitCollection)
    }
    
    func resetViewsForNewInterfaceStyle(_ previousTraitCollection: UITraitCollection?) {
        switch previousTraitCollection?.userInterfaceStyle {
            
            // Change from light mode to dark mode.
        case .light:
            createAccountButton.addShadowToView(shadowColor: .clear, offset: CGSize(width: 0, height: 0), shadowRadius: 0, shadowOpacity: 0, cornerRadius: 10)
        
            // Change from dark mode to light mode.
        case .dark:
            createAccountButton.addShadowToView(shadowColor: WColors.purple!, offset: CGSize(width: 0, height: 20), shadowRadius: 30, shadowOpacity: 0.7, cornerRadius: 10)
            
            // Do nothing, view shouldn't change.
        default:
            print("We have no information about user interface style")
        }
    }
}
