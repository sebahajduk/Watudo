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
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor
                                               )
        ])
    }
    
    func setVC(user: User) {
        self.user = user
    }
    
}
