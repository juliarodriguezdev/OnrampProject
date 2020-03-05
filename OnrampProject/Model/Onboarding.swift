//
//  Onboarding.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class Onboarding {
    
    var introTitle: String
    var introMessage: String
    var buttonTitle: String
    
    init(introTitle: String = "Welcome!", introMessage: String = "On the next screen, \nenter a city, country to \ndisplay weather info", buttonTitle: String = "Continue") {
        self.introTitle = introTitle
        self.introMessage = introMessage
        self.buttonTitle = buttonTitle
    }
    
}
