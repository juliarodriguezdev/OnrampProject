//
//  CountrySelection.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import Foundation

class CountrySelection {
    
    let message: String
    let usaSegment: String
    let internationalSegment: String
    let continueButton: String
    var isUSA: Bool
    let buttonTitle: String
    
    init(message: String = "Where is the weather located?", usaSegment: String = "USA", internSegment: String = "International", continueButton: String = "Continue", isUSA: Bool = true, buttonTitle: String = "Continue") {
        self.message = message
        self.usaSegment = usaSegment
        self.internationalSegment = internSegment
        self.continueButton = continueButton
        self.isUSA = isUSA
        self.buttonTitle = buttonTitle
    }
}
