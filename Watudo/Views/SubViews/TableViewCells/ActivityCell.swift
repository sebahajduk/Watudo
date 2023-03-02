//
//  ActivityCell.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 02/01/2023.
//

import UIKit

enum WCellStyle {
    case activity, report
}

class ActivityCell: UITableViewCell {

    static let reuseID = "ActivityCell"
    
    let visualEffect = WVisualEffectView(cornerRadius: 20)
    
    let name = UILabel()
    let time = UILabel()
    let playStopImage = UIImageView()
    
    var isCounting = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        if selected {
            playStopImage.image = UIImage(systemName: "pause.fill")
        } else {
            playStopImage.image = UIImage(systemName: "play.fill")
            
        }
        
    }
    
    func set(for activity: Activity, style: WCellStyle) {
        backgroundColor = .clear
        configure()
        name.text = activity.name
        name.textColor = WColors.foreground
        name.font = .boldSystemFont(ofSize: 15)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        
        time.text = formatter.string(from: activity.timeSpent)
        time.textColor = WColors.foreground
        time.font = .systemFont(ofSize: 15)
        
        switch style {
        case .activity:
            print()
        case .report:
            playStopImage.removeFromSuperview()
        }
    }
    
    private func configure() {
        let views = [visualEffect, name, time, playStopImage]
        addSubviews(views)
        
        playStopImage.tintColor = WColors.green!
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            visualEffect.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffect.centerYAnchor.constraint(equalTo: centerYAnchor),
            visualEffect.heightAnchor.constraint(equalToConstant: 65),
            visualEffect.widthAnchor.constraint(equalToConstant: 330),

            name.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            name.heightAnchor.constraint(equalToConstant: 20),
            name.widthAnchor.constraint(equalToConstant: 200),
            
            time.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            time.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 20),
            time.heightAnchor.constraint(equalToConstant: 20),
            time.widthAnchor.constraint(equalToConstant: 100),
            
            playStopImage.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -30),
            playStopImage.centerYAnchor.constraint(equalTo: visualEffect.centerYAnchor),
            playStopImage.widthAnchor.constraint(equalToConstant: 15),
            playStopImage.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
