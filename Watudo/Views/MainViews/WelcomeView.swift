//
//  WelcomView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 06/12/2022.
//

import UIKit
import Lottie

class WelcomeView: UIView {
    
    let helloLabel = UILabel()
    let greetingLabel = UILabel()

    let loginView = LoginView()
    let registerView = RegisterView()
    let scrollView = UIScrollView()
    
    private var lastContentOffset: CGFloat = 0
    private var isShipZoomed = false
    
    private var dotsAnimationBackground: LottieAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = WColors.background
        
        dotsAnimationBackground = .init(name: "dots")
        dotsAnimationBackground!.frame = bounds
        dotsAnimationBackground!.contentMode = .scaleAspectFit
        dotsAnimationBackground!.loopMode = .loop
        dotsAnimationBackground!.animationSpeed = 0.5
        dotsAnimationBackground!.translatesAutoresizingMaskIntoConstraints = false
        dotsAnimationBackground?.alpha = 0.1
        addSubview(dotsAnimationBackground!)
        dotsAnimationBackground!.play()
        
        configure()
    }
    
    private func configure() {
        configureScrollView()
        configureConstraints()
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureScrollView() {
        addSubviews([scrollView])
        scrollView.addSubviews([loginView, registerView])
        scrollView.delegate = self
        
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
                
        registerView.alpha = 0
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            dotsAnimationBackground!.topAnchor.constraint(equalTo: topAnchor),
            dotsAnimationBackground!.leadingAnchor.constraint(equalTo: leadingAnchor),
            dotsAnimationBackground!.trailingAnchor.constraint(equalTo: trailingAnchor),
            dotsAnimationBackground!.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loginView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 140),
            loginView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            loginView.widthAnchor.constraint(equalTo: widthAnchor),
            loginView.heightAnchor.constraint(equalToConstant: 500),
            
            registerView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 130),
            registerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            registerView.widthAnchor.constraint(equalTo: widthAnchor),
            registerView.heightAnchor.constraint(equalToConstant: 700),
            registerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WelcomeView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 100 {
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.loginView.alpha = 1.0
                self?.registerView.alpha = 0.0
            }
        } else if scrollView.contentOffset.y > 100 {
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.loginView.alpha = 0
                self?.registerView.alpha = 1.0
            }
        }
    }
}
