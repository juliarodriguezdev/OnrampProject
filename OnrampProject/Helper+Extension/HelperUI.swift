//
//  HelperUI.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class HelperUI {
    
    let continueText: String
    let addText: String
    let homeText: String
    let placeholderText: String
    let statePlaceholderText: String
    let invalidEntryText: String
    let invalideEntryMessage: String
    let stateText: String
    
    init(continueText: String = "Continue", addText: String = "Add", homeText: String = "Home", placeholderText: String = "Begin typing city here...", statePlaceholderText: String = "Begin typing state here...", invalidEntryText: String = "Invalid Entry", invalidEntryMessage: String = "Invalid location entry, please select from the provided locations", stateText: String = "What State is this city in?") {
        self.continueText = continueText
        self.addText = addText
        self.homeText = homeText
        self.placeholderText = placeholderText
        self.statePlaceholderText = statePlaceholderText
        self.invalidEntryText = invalidEntryText
        self.invalideEntryMessage = invalidEntryMessage
        self.stateText = stateText
    }
    
    static func configShadowForView(viewName: UIView, cornerRadius: CGFloat,  shadowRadius: CGFloat) {
        viewName.layer.cornerRadius = cornerRadius
        viewName.layer.shadowColor = UIColor.black.cgColor
        viewName.layer.shadowOpacity = 0.7
        viewName.layer.shadowOffset = .zero
        viewName.layer.shadowRadius = shadowRadius
        viewName.layer.shadowPath = UIBezierPath(rect: viewName.bounds).cgPath
        viewName.layer.shouldRasterize = true
        viewName.layer.rasterizationScale = UIScreen.main.scale
    }
    
    
}


