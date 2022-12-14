//
//  RegisterView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 04/12/2022.
//

import UIKit

class RegisterView: UIView {
    
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
    
    private func configureTextFields() {
        addSubviews([nicknameTextField, emailTextField, passwordTextField, repeatPasswordTextField, nicknameImage, emailImage, passwordImage, passwordRepeatImage])
        
        nicknameTextField.placeholder = "Nickname"
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        repeatPasswordTextField.placeholder = "Repeat password"
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        nicknameImage.tintColor = .gray.withAlphaComponent(0.7)
        nicknameImage.contentMode = .scaleAspectFit
        nicknameImage.translatesAutoresizingMaskIntoConstraints = false
        
        emailImage.tintColor = .gray.withAlphaComponent(0.7)
        emailImage.contentMode = .scaleAspectFit
        emailImage.translatesAutoresizingMaskIntoConstraints = false
        
        passwordImage.tintColor = .gray.withAlphaComponent(0.7)
        passwordImage.contentMode = .scaleAspectFit
        passwordImage.translatesAutoresizingMaskIntoConstraints = false
        
        passwordRepeatImage.tintColor = .gray.withAlphaComponent(0.7)
        passwordRepeatImage.contentMode = .scaleAspectFit
        passwordRepeatImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayoutElements() {
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
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            greetingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            greetingLabel.heightAnchor.constraint(equalToConstant: 85),
            
            greetingDescriptionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
            greetingDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            greetingDescriptionLabel.widthAnchor.constraint(equalToConstant: 290),
            greetingDescriptionLabel.heightAnchor.constraint(equalToConstant: 60),
            
            materialBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            materialBackground.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 160),
            materialBackground.heightAnchor.constraint(equalToConstant: 189),
            materialBackground.widthAnchor.constraint(equalToConstant: 330),
            
            nicknameTextField.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            nicknameTextField.topAnchor.constraint(equalTo: materialBackground.topAnchor, constant: 5),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 44),
            nicknameTextField.widthAnchor.constraint(equalToConstant: 290),
            
            nicknameImage.trailingAnchor.constraint(equalTo: nicknameTextField.trailingAnchor),
            nicknameImage.centerYAnchor.constraint(equalTo: nicknameTextField.centerYAnchor),
            nicknameImage.heightAnchor.constraint(equalToConstant: 20),
            nicknameImage.widthAnchor.constraint(equalToConstant: 20),
            
            firstDivider.widthAnchor.constraint(equalToConstant: 270),
            firstDivider.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor),
            firstDivider.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            
            emailTextField.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: firstDivider.bottomAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.widthAnchor.constraint(equalToConstant: 290),
            
            emailImage.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            emailImage.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            emailImage.heightAnchor.constraint(equalToConstant: 20),
            emailImage.widthAnchor.constraint(equalToConstant: 20),
            
            secondDivider.widthAnchor.constraint(equalToConstant: 270),
            secondDivider.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            secondDivider.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            
            passwordTextField.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: secondDivider.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.widthAnchor.constraint(equalToConstant: 290),
            
            passwordImage.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            passwordImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordImage.heightAnchor.constraint(equalToConstant: 20),
            passwordImage.widthAnchor.constraint(equalToConstant: 20),
            
            thirdDivider.widthAnchor.constraint(equalToConstant: 270),
            thirdDivider.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            thirdDivider.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            
            repeatPasswordTextField.centerXAnchor.constraint(equalTo: materialBackground.centerXAnchor),
            repeatPasswordTextField.bottomAnchor.constraint(equalTo: materialBackground.bottomAnchor, constant: -6),
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

@objc protocol RegisterViewActionHandler {
    
}
