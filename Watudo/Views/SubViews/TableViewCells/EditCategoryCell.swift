//
//  EditCategoryCell.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 08/03/2023.
//

import UIKit

class EditCategoryCell: UITableViewCell {

    static let reuseID = "EditCategoryCell"
    private let label = UILabel()
    private let editImage = UIImageView(image: UIImage(systemName: "pencil"))

    func set(for category: Category) {
        label.text = category.name
        configure()
    }

    private func configure() {
        addSubviews([label, editImage])
        backgroundColor = .clear
        editImage.tintColor = WColors.green
        label.textColor = WColors.foreground

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.widthAnchor.constraint(equalToConstant: 200),

            editImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            editImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            editImage.heightAnchor.constraint(equalToConstant: 20),
            editImage.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
