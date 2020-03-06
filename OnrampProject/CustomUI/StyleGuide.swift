//
//  StyleGuide.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/5/20.
//

import UIKit

extension UIView {
    func addCornerRadius(_ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
    }
}

struct FontNames {
    static let avenirHeavy = "Avenir-Heavy"
    static let avenirBook = "Avenir-Book"
    static let avenirMedium = "Avenir-Medium"
}

extension UIColor {
    static let customBrightBlue = UIColor(named: "customBrightBlue")
    static let customLightBlue = UIColor(named: "customLightBlue")
    static let customLightOrange = UIColor(named: "customLightOrange")
    static let customNightGray = UIColor(named: "customNightGray")
    static let customOpaqueBlue = UIColor(named: "customOpaqueBlue")
    static let customOrange = UIColor(named: "customOrange")
    static let customThunderGray = UIColor(named: "customThunderGray")
    static let customVeryLightBlue = UIColor(named: "customVeryLightBlue")
    static let customVeryLightOrange = UIColor(named: "customVeryLightOrange")
}
