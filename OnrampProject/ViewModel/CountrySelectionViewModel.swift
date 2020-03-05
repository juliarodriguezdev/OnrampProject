//
//  CountrySelectionViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class CountrySelectionViewModel {
    
    private let countryModel = CountrySelection()
  //  let countryViewController = CountrySelectionViewController()
    
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
}

extension CountrySelectionViewModel: CountryViewControllerDelegate {
    
    func updateCountrySelection(sender: CountrySelectionViewController, isUSA: Bool) {
        sender.delegate = self
        if isUSA {
            countryModel.isUSA = true
        } else {
            countryModel.isUSA = false
        }
    }
}