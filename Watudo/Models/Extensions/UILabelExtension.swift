//
//  UILabelExtension.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 24/01/2023.
//

import UIKit

extension UILabel {
    func calculateMaxLines() -> Int {
            let maxSize = CGSize(width: 300, height: CGFloat(Float.infinity))
            let charSize = font.lineHeight
            let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font!], context: nil)
            let linesRoundedUp = Int(ceil(textSize.height/charSize))
            return linesRoundedUp
        }
}
