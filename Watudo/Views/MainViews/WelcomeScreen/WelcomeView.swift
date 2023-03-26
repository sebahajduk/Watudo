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

    private var dotsAnimationBackground: LottieAnimationView?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = WColors.background

        dotsAnimationBackground = .init(name: "dots")
        dotsAnimationBackground!.frame = bounds
        dotsAnimationBackground!.contentMode = .scaleAspectFit
        dotsAnimationBackground!.loopMode = .loop
        dotsAnimationBackground!.animationSpeed = 0.5
        dotsAnimationBackground?.alpha = 0.1
        dotsAnimationBackground!.play()
        addSubviews([dotsAnimationBackground!])
        configure()

        registerView.emailTextField.delegate = self
        registerView.passwordTextField.delegate = self
        registerView.repeatPasswordTextField.delegate = self
    }

    private func configure() {
        configureScrollView()
        configureConstraints()

        translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(loginView)
        scrollView.addSubview(registerView)
        scrollView.delegate = self

        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.shouldIgnoreScrollingAdjustment = true
        scrollView.showsVerticalScrollIndicator = false
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

            loginView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Dimension.welcomeViewLoginViewTopAnchor),
            loginView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            loginView.heightAnchor.constraint(equalToConstant: Dimension.welcomeViewLoginViewHeightAnchor),
            loginView.widthAnchor.constraint(equalTo: widthAnchor),

            registerView.topAnchor.constraint(equalTo: loginView.bottomAnchor),
            registerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            registerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50),
            registerView.heightAnchor.constraint(equalToConstant: Dimension.welcomeViewRegisteViewHeightAnchor),
            registerView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WelcomeView: UIScrollViewDelegate {

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

@objc protocol WelcomeViewTFListener {
    func textFieldDidChange(_ sender: UITextField)
}

extension WelcomeView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.scrollView.isPagingEnabled = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.isPagingEnabled = false
    }
}
