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
        
        if UserDefaults.standard.bool(forKey: UserDefaultKeys.firstLaunchKey) == true {
            print("Second+ Launch")
            showMainLocationsViewController()
        } else {
            print("First Launch")
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.firstLaunchKey)
            showOnboardingViewController()
            
        }
    }
    
    // MARK: - Navigation 
    func showOnboardingViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let onboardingViewController = storyboard.instantiateViewController(identifier: "OnboardingViewController") as? OnboardingViewController else { return }
        
        self.navigationController?.pushViewController(onboardingViewController, animated: true)
    }
    
    func showMainLocationsViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainLocationsViewController = storyboard.instantiateViewController(identifier: "UserLocationsViewController") as? UserLocationsViewController else { return }
        self.navigationController?.pushViewController(mainLocationsViewController, animated: true)
    }

}
