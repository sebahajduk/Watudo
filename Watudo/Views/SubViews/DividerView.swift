//
//  DividerView.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 03/12/2022.
//

import UIKit

class DividerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground.withAlphaComponent(0.2)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


