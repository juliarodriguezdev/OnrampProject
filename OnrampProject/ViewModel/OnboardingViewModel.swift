//
//  OnboardingViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class OnboardingViewModel {
    
    private let onboardingModel = Onboarding()
    
    var title: String {
        return onboardingModel.introTitle
      }
      
      var message: String {
          return onboardingModel.introMessage
      }
      
      var buttonTitle: String {
          return onboardingModel.buttonTitle
      }
    
    func setFirstLaunchToTrue() {
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.firstLaunchKey)
    }
    
    
}
