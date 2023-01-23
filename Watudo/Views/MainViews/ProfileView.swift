//
//  ProfileView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/01/2023.
//

import UIKit

class ProfileView: UIView {

    let profileImage = UIImageView()
    let nameLabel = UILabel()
    
    let appearenceModeSwitch = UISwitch()
    let appearenceModeLabel = UILabel()
    
    let categoriesEditButton = WButton(title: "Edit categories", role: .primary)
    let signOutButton = WButton(title: "Sign out", role: .secondary)
    
    // Time zone (24h/12h)
    // Face ID
    // Send feedback
    // Delete activities history
    // Notifications
    // Reminders time
    
    let timeZoneLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = WColors.background
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let views: [UIView] = [profileImage, nameLabel, appearenceModeLabel, appearenceModeSwitch, categoriesEditButton, signOutButton]
        addSubviews(views)
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileImage.image = UIImage(systemName: "camera")
        profileImage.contentMode = .scaleAspectFit
        profileImage.backgroundColor = WColors.foreground?.withAlphaComponent(0.05)
        profileImage.tintColor = WColors.purple!.withAlphaComponent(0.5)
        profileImage.addCornerRadius(radius: 75)
        
        nameLabel.text = "Micheal Myers"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Panton-BlackCaps", size: 20)
        
        appearenceModeLabel.text = "Dark mode"
        appearenceModeLabel.font = UIFont(name: "Panton-BlackCaps", size: 15)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            
            appearenceModeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 100),
            appearenceModeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            appearenceModeLabel.widthAnchor.constraint(equalToConstant: 100),
            appearenceModeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            appearenceModeSwitch.centerYAnchor.constraint(equalTo: appearenceModeLabel.centerYAnchor),
            appearenceModeSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            signOutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            signOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 290),
            signOutButton.heightAnchor.constraint(equalToConstant: 44),
            
            categoriesEditButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -10),
            categoriesEditButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoriesEditButton.widthAnchor.constraint(equalToConstant: 290),
            categoriesEditButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}
