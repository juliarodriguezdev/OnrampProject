//
//  OnboardingViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let onboardingViewModel = OnboardingViewModel()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var buttonText: OrangeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        showSelectCountryViewController()
    }
    
    func updateUI() {
        titleLabel.text = onboardingViewModel.title
        messageLabel.text = onboardingViewModel.message
        buttonText.setTitle(onboardingViewModel.buttonTitle, for: .normal)
    }

    // MARK: - Navigation
    
    func showSelectCountryViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let selectCountryViewController = storyboard.instantiateViewController(identifier: "CountrySelectionViewController") as? CountrySelectionViewController else { return }
        self.navigationController?.pushViewController(selectCountryViewController, animated: true)
    }
    

}
