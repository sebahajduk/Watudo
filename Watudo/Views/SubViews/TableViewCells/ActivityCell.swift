//
//  ActivityCell.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 02/01/2023.
//

import UIKit

class ActivityCell: UITableViewCell {

    static let reuseID = "ActivityCell"
    
    let visualEffect = UIVisualEffectView()
    
    let name = UILabel()
    let time = UILabel()

    
    
    func set() {
        backgroundColor = WColors.background
        configure()
        name.text = "Coding"
        name.textColor = WColors.purple
        name.font = .boldSystemFont(ofSize: 15)
        
        time.text = "0:30 / 2:30"
        time.textColor = WColors.purple
        time.font = .systemFont(ofSize: 15)
    }
    
    private func configure() {
        let views = [visualEffect, name, time]
        addSubviews(views)
        
        visualEffect.addShadowToView(shadowColor: .clear, offset: CGSize(width: 0, height: 0), shadowRadius: 5, shadowOpacity: 0.2, cornerRadius: 10)
        
        visualEffect.backgroundColor = .systemBackground
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            visualEffect.topAnchor.constraint(equalTo: topAnchor),
            visualEffect.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffect.heightAnchor.constraint(equalToConstant: 65),
            visualEffect.widthAnchor.constraint(equalToConstant: 330),

            name.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            name.heightAnchor.constraint(equalToConstant: 20),
            name.widthAnchor.constraint(equalToConstant: 100),
            
            time.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            time.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            time.heightAnchor.constraint(equalToConstant: 20),
            time.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
