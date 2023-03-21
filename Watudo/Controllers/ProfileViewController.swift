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
        guard Defaults.shared.isDarkMode != nil else { return }

        if Defaults.shared.isDarkMode! {
            profileView.appearenceModeSwitch.isOn = Defaults.shared.isDarkMode!
        } else {
            profileView.appearenceModeSwitch.isOn = traitCollection.userInterfaceStyle == .dark ? true : false
        }
    }
}

extension ProfileViewController: ProfileViewActionHandler {
    func deleteAccountTapped(_ sender: UIButton) {
        FirebaseManager.shared.deleteAccount { err in
            guard let err else {
                self.presentAlert(title: "Account deleted",
                                  message: "Thank you for being with us for such a long time!")
                do {
                    try FirebaseManager.shared.signOut()
                } catch {
                    self.presentAlert(title: "Error", message: error.localizedDescription)
                }
                return
            }

            self.presentAlert(title: "Error", message: err.localizedDescription)
        }
    }

    func editCategoryButtonTapped(_ sender: UIButton) {
        let editCategoryVC = EditCategoryViewController()
        editCategoryVC.sheetPresentationController?.detents = [.medium()]
        present(editCategoryVC, animated: true)
    }

    func signOutButtonTapped(_ sender: UIButton) {
        do {
            try FirebaseManager.shared.signOut()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                .changeRootViewController(WelcomeViewController())
        } catch {
            self.presentAlert(error)
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
