//
//  CountrySelectionViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class CountrySelectionViewModel {
    
    private let countryModel = CountrySelection()
    
    var message: String {
        return countryModel.message
    }
    
    var segmentZero: String {
        return countryModel.usaSegment
    }
    
    var segmentOne: String {
        return countryModel.internationalSegment
    }
    
    var buttonTitle: String {
        return countryModel.continueButton
    }
    
    func fetchIsUSASelected() -> Bool {
        print("FetchIsUSASelected: \(countryModel.isUSA)")
        return countryModel.isUSA
        
    }
    func updateCountryModelSelection(isInUSA: Bool) {
        if isInUSA == true {
            countryModel.isUSA = true
        } else {
            countryModel.isUSA = false
        }
    }
}
