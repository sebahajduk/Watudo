//
//  LoginView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/12/2022.
//

import UIKit

class LoginView: UIView {
    
    let firstTimeHereButton = UIButton()
    let backgroundImage = UIImageView(image: UIImage(named: "loginBackground"))
    let clockImage = UIImageView(image: UIImage(named: "timeImageLoginScreen"))
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    
    let divider = DividerView()

    let emailImage = UIImageView(image: UIImage(systemName: "at"))
    let passwordImage = UIImageView(image: UIImage(systemName: "lock.fill"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
    }
    
    private func configureUI() {
        configureLayoutElements()
        configureTextFields()
        configureButtons()
        configureConstraints()
    }
    
    private func configureTextFields() {
        addSubviews([emailTextField, passwordTextField, emailImage, passwordImage])
        
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        
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
        addSubviews([backgroundImage, clockImage, visualEffectView, divider])
        
        backgroundImage.alpha = 0.8
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        clockImage.contentMode = .scaleAspectFit
        clockImage.translatesAutoresizingMaskIntoConstraints = false
        
        visualEffectView.layer.cornerRadius = 8
        visualEffectView.clipsToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureButtons() {
        addSubviews([firstTimeHereButton])
        
        firstTimeHereButton.setTitle("First time here? Create account!", for: .normal)
        firstTimeHereButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        firstTimeHereButton.setTitleColor(.secondaryLabel, for: .highlighted)
        firstTimeHereButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        firstTimeHereButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc func buttonTapped() {
        UIApplication.shared.sendAction(#selector(LoginViewActionHandler.createAccountTapped), to: nil, from: self, for: nil)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor, constant: -5),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            
            clockImage.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            clockImage.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -100),
            clockImage.widthAnchor.constraint(equalToConstant: 250),
            clockImage.heightAnchor.constraint(equalToConstant: 150),
            
            visualEffectView.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffectView.centerYAnchor.constraint(equalTo: centerYAnchor),
            visualEffectView.heightAnchor.constraint(equalToConstant: 105),
            visualEffectView.widthAnchor.constraint(equalToConstant: 330),
            
            emailTextField.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 5),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.widthAnchor.constraint(equalToConstant: 290),
            
            emailImage.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            emailImage.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            emailImage.heightAnchor.constraint(equalToConstant: 20),
            emailImage.widthAnchor.constraint(equalToConstant: 20),

            passwordTextField.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -5),
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
            
            firstTimeHereButton.topAnchor.constraint(equalTo: clockImage.bottomAnchor, constant: 40),
            firstTimeHereButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            firstTimeHereButton.heightAnchor.constraint(equalToConstant: 15),
            firstTimeHereButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

@objc protocol LoginViewActionHandler: AnyObject {
    func createAccountTapped(sender: Any?)
    func loginButtonTapped(sender: Any?)
}
