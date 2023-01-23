//
//  ActivityCell.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 02/01/2023.
//

import UIKit

class ActivityCell: UITableViewCell {

    static let reuseID = "ActivityCell"
    
    let visualEffect = WVisualEffectView(cornerRadius: 20)
    
    let name = UILabel()
    let time = UILabel()
    let playStopImage = UIImageView(image: UIImage(systemName: "play.fill"))
    
    
    func set(activityName: String) {
        backgroundColor = .clear
        configure()
        name.text = activityName
        name.textColor = WColors.foreground
        name.font = .boldSystemFont(ofSize: 15)
        
        time.text = "0:00:00"
        time.textColor = WColors.foreground
        time.font = .systemFont(ofSize: 15)
    }
    
    private func configure() {
        let views = [visualEffect, name, time, playStopImage]
        addSubviews(views)
        
        playStopImage.tintColor = WColors.green!
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            visualEffect.centerYAnchor.constraint(equalTo: centerYAnchor),
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
            time.widthAnchor.constraint(equalToConstant: 100),
            
            playStopImage.centerYAnchor.constraint(equalTo: visualEffect.centerYAnchor),
            playStopImage.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -30),
            playStopImage.widthAnchor.constraint(equalToConstant: 15),
            playStopImage.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
