//
//  LaunchViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.userDefaultsObject.bool(forKey: UserDefaultKeys.firstLaunchKey) == true {
            print("Second+ Launch")
            showMainLocationsViewController()
        } else {
            print("First Launch")
            UserDefaults.userDefaultsObject.set(true, forKey: UserDefaultKeys.firstLaunchKey)
            // navigate to Onboarding VC
            showOnboardingViewController()
            
        }
    }
    
    func showOnboardingViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let onboardingViewController = storyboard.instantiateViewController(identifier: "OnboardingViewController") as? OnboardingViewController else { return }
        
        self.navigationController?.pushViewController(onboardingViewController, animated: true)
    }
    
    func showMainLocationsViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainLocationsViewController = storyboard.instantiateViewController(identifier: "LocationsViewController") as? LocationsViewController else { return }
        self.navigationController?.pushViewController(mainLocationsViewController, animated: true)
    }

}
