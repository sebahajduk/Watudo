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
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    
    let divider = DividerView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubviews([backgroundImage, clockImage, visualEffectView, loginTextField, passwordTextField, divider, firstTimeHereButton])
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        loginTextField.placeholder = "Login"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.alpha = 0.8
        clockImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFit
        clockImage.contentMode = .scaleAspectFit
        firstTimeHereButton.setTitle("First time here? Create account!", for: .normal)
        firstTimeHereButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        firstTimeHereButton.setTitleColor(.secondaryLabel, for: .highlighted)
        firstTimeHereButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        firstTimeHereButton.translatesAutoresizingMaskIntoConstraints = false
        
        translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.layer.cornerRadius = 8
        visualEffectView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            clockImage.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            clockImage.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -100),
            clockImage.widthAnchor.constraint(equalToConstant: 250),
            clockImage.heightAnchor.constraint(equalToConstant: 150),
            
            visualEffectView.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffectView.centerYAnchor.constraint(equalTo: centerYAnchor),
            visualEffectView.heightAnchor.constraint(equalToConstant: 105),
            visualEffectView.widthAnchor.constraint(equalToConstant: 330),
            
            loginTextField.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            loginTextField.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 5),
            loginTextField.heightAnchor.constraint(equalToConstant: 44),
            loginTextField.widthAnchor.constraint(equalToConstant: 310),
            
            passwordTextField.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -5),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.widthAnchor.constraint(equalToConstant: 310),
            
            divider.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            divider.centerYAnchor.constraint(equalTo: visualEffectView.centerYAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.widthAnchor.constraint(equalToConstant: 290),
            
            firstTimeHereButton.topAnchor.constraint(equalTo: clockImage.bottomAnchor, constant: 40),
            firstTimeHereButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            firstTimeHereButton.heightAnchor.constraint(equalToConstant: 15),
            firstTimeHereButton.widthAnchor.constraint(equalToConstant: 250)
            
        ])
    }
    
    @objc private func buttonTapped() {
        print("Tapped")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
