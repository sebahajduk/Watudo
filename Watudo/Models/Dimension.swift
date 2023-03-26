//
//  Dimension.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 25/03/2023.
//

import Foundation
import DeviceKit


/// Name creating structure:
///  - Class name + view name + constraint
struct Dimension {
    static let isIphoneSE: Bool = {
        if Device.current == .iPhoneSE3 || Device.current == .simulator(.iPhoneSE3) {
            return true
        } else {
            return false
        }
    }()

    // MARK: Welcome View
    static let welcomeViewLoginViewTopAnchor: CGFloat = isIphoneSE ? 70 : 140
    static let welcomeViewLoginViewHeightAnchor: CGFloat = isIphoneSE ? 550 : 700

    static let welcomeViewRegisteViewHeightAnchor: CGFloat = isIphoneSE ? 550 : 700

    // MARK: Login View
    static let loginViewVisualEffectViewTopAnchor: CGFloat = isIphoneSE ? 80 : 160

    // MARK: Reports View
    static let reportsViewChartViewHeightAnchor: CGFloat = isIphoneSE ? 200 : 300
}
