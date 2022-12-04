//
//  RegisterView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 04/12/2022.
//

import UIKit

class RegisterView: UIView {

    let backgroundImage = UIImageView(image: UIImage(named: "loginBackground"))
    let welcomeImage = UIImageView(image: UIImage(named: "registerImage"))
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
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
        addSubviews([backgroundImage, welcomeImage, materialBackground, firstDivider, secondDivider, thirdDivider])
        
        backgroundImage.alpha = 0.8
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeImage.contentMode = .scaleAspectFit
        welcomeImage.translatesAutoresizingMaskIntoConstraints = false
        
        materialBackground.layer.cornerRadius = 8
        materialBackground.clipsToBounds = true
        materialBackground.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor, constant: -5),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            
            welcomeImage.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            welcomeImage.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -100),
            welcomeImage.widthAnchor.constraint(equalToConstant: 250),
            welcomeImage.heightAnchor.constraint(equalToConstant: 150),
            
            materialBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            materialBackground.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
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
            passwordRepeatImage.widthAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    @objc private func buttonTapped() {
        print("Tapped")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
