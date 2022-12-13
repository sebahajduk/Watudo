//
//  WelcomView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 06/12/2022.
//

import UIKit

class WelcomeView: UIView {

    let loginView = LoginView()
    let registerView = RegisterView()
    let takenImage = UIImageView(image: UIImage(named: "takenWithoutShip"))
    let shipImage = UIImageView(image: UIImage(named: "Ship"))
    let scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        configure()
    }
    
    private func configure() {
        configureScrollView()
        configureConstraints()
        configureAnimation()
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureScrollView() {
        addSubview(scrollView)
        scrollView.addSubviews([loginView, shipImage, takenImage, registerView])
        
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        shipImage.contentMode = .scaleAspectFit
        shipImage.translatesAutoresizingMaskIntoConstraints = false
        
        takenImage.contentMode = .scaleAspectFit
        takenImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAnimation() {
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        
        scaleAnimation.duration = 5.0
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.2
        
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.shipImage.transform = CGAffineTransform(translationX: 0, y: 40)
        }
        
        self.shipImage.layer.add(scaleAnimation, forKey: "scale")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loginView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            loginView.widthAnchor.constraint(equalTo: widthAnchor),
            loginView.heightAnchor.constraint(equalToConstant: 600),
            
            shipImage.topAnchor.constraint(equalTo: loginView.bottomAnchor),
            shipImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            shipImage.widthAnchor.constraint(equalTo: widthAnchor),
            shipImage.heightAnchor.constraint(equalToConstant: 300),
            
            takenImage.topAnchor.constraint(equalTo: shipImage.bottomAnchor, constant: -250),
            takenImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            takenImage.widthAnchor.constraint(equalTo: widthAnchor),
            takenImage.heightAnchor.constraint(equalToConstant: 300),
            
            registerView.topAnchor.constraint(equalTo: takenImage.bottomAnchor),
            registerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            registerView.widthAnchor.constraint(equalTo: widthAnchor),
            registerView.heightAnchor.constraint(equalToConstant: 300),
            registerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
