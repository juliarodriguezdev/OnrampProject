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
    
    init(message: String = "Select the country of weather", usaSegment: String = "USA", internSegment: String = "International", continueButton: String = "Continue", isUSA: Bool = true) {
        self.message = message
        self.usaSegment = usaSegment
        self.internationalSegment = internSegment
        self.continueButton = continueButton
        self.isUSA = isUSA
    }
}
