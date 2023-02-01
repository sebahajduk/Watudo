//
//  ProfileViewController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/01/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileView = ProfileView()
    var user: User? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.nameLabel.text = user?.name ?? "Unknown"
        loadSwitchValue()
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setVC(user: User) {
        self.user = user
    }
    
    private func loadSwitchValue() {
        if Defaults.shared.isDarkMode != nil {
            profileView.appearenceModeSwitch.isOn = Defaults.shared.isDarkMode
        } else {
            profileView.appearenceModeSwitch.isOn = traitCollection.userInterfaceStyle == .dark ? true : false
        }
    }
}

extension ProfileViewController: ProfileViewActionHandler {
    func switchChanged(mySwitch: UISwitch) {
        let isDarkMode = mySwitch.isOn
        let window: UIWindow? = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first
        
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
