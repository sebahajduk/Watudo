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

    var dolarView: UIImageView = UIImageView()

    let visualEffect = WVisualEffectView(cornerRadius: 20)

    let name = UILabel()
    let time = UILabel()
    let playStopImage = UIImageView()
    let moneyEarnedLabel = UILabel()

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
        var moneyEarned = 0.0

        if activity.isPaid {
            let config = UIImage.SymbolConfiguration(hierarchicalColor: WColors.green!)
            let image = UIImage(systemName: "dollarsign.circle.fill", withConfiguration: config)
            dolarView.image = image
            moneyEarned = (activity.timeSpent / 3600) * activity.moneyPerHour
            moneyEarnedLabel.text = "$ " + String(format: "%.2f", moneyEarned)
            moneyEarnedLabel.textColor = WColors.green!
            moneyEarnedLabel.textAlignment = .right
            moneyEarnedLabel.font = .boldSystemFont(ofSize: 15)
        } else {
            let config = UIImage.SymbolConfiguration(hierarchicalColor: WColors.purple!.withAlphaComponent(0.3))
            let image = UIImage(systemName: "dollarsign.circle.fill", withConfiguration: config)
            dolarView.image = image
            moneyEarnedLabel.text = ""
        }

        if style == .report {
            playStopImage.removeFromSuperview()
        } else {
            moneyEarnedLabel.removeFromSuperview()
        }
    }

    private func configure() {
        let views = [visualEffect, dolarView, name, time, playStopImage, moneyEarnedLabel]
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

            dolarView.centerYAnchor.constraint(equalTo: visualEffect.centerYAnchor),
            dolarView.leadingAnchor.constraint(equalToSystemSpacingAfter: visualEffect.leadingAnchor, multiplier: 1),
            dolarView.heightAnchor.constraint(equalToConstant: 30),
            dolarView.widthAnchor.constraint(equalToConstant: 30),

            name.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalToSystemSpacingAfter: dolarView.trailingAnchor, multiplier: 1.5),
            name.heightAnchor.constraint(equalToConstant: 20),
            name.widthAnchor.constraint(equalToConstant: 200),

            time.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            time.leadingAnchor.constraint(equalToSystemSpacingAfter: dolarView.trailingAnchor, multiplier: 1.5),
            time.heightAnchor.constraint(equalToConstant: 20),
            time.widthAnchor.constraint(equalToConstant: 100),

            playStopImage.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -30),
            playStopImage.centerYAnchor.constraint(equalTo: visualEffect.centerYAnchor),
            playStopImage.widthAnchor.constraint(equalToConstant: 15),
            playStopImage.heightAnchor.constraint(equalToConstant: 20),

            moneyEarnedLabel.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -20),
            moneyEarnedLabel.centerYAnchor.constraint(equalTo: visualEffect.centerYAnchor),
            moneyEarnedLabel.widthAnchor.constraint(equalToConstant: 70),
            moneyEarnedLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

}
