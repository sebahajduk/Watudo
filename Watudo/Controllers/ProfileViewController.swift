//
//  ProfileViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/01/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.nameLabel.text = LocalUserManager.shared.getUsername()
        loadSwitchValue()

        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadSwitchValue() {
        if Defaults.shared.isDarkMode {
            profileView.appearenceModeSwitch.isOn = Defaults.shared.isDarkMode
        } else {
            profileView.appearenceModeSwitch.isOn = traitCollection.userInterfaceStyle == .dark ? true : false
        }
    }
}

extension ProfileViewController: ProfileViewActionHandler {
    func editCategoryButtonTapped() {
        let editCategoryVC = EditCategoryViewController()
        editCategoryVC.sheetPresentationController?.detents = [.medium()]
        present(editCategoryVC, animated: true)
    }

    func signOutButtonTapped() {
        do {
            try FirebaseManager.shared.signOut()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                .changeRootViewController(WelcomeViewController())
        } catch {
            print("There was an error signing out.")
        }
    }

    func switchChanged(mySwitch: UISwitch) {
        let isDarkMode = mySwitch.isOn
        let connectedScenesRef = UIApplication.shared.connectedScenes
        let window: UIWindow? = connectedScenesRef.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first

        guard let window else { return }
        if isDarkMode {
            window.overrideUserInterfaceStyle = .unspecified
            window.overrideUserInterfaceStyle = .dark
            window.layoutIfNeeded()
            Defaults.shared.isDarkMode = true

        } else {
            window.overrideUserInterfaceStyle = .unspecified
            window.overrideUserInterfaceStyle = .light
            window.layoutIfNeeded()
            Defaults.shared.isDarkMode = false
        }
    }
}
