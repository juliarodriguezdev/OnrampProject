//
//  OnboardingViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class OnboardingViewController: UIViewController {
    
   // var viewModel = OnboardingViewModel!()
    let onboardingViewModel = OnboardingViewModel()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var buttonText: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func continueButtonTapped(_ sender: Any) {
        showSelectCountryViewController()
    }
    
    func updateUI() {
        titleLabel.text = onboardingViewModel.title
        messageLabel.text = onboardingViewModel.message
        buttonText.setTitle(onboardingViewModel.buttonTitle, for: .normal)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showSelectCountryViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let selectCountryViewController = storyboard.instantiateViewController(identifier: "CountrySelectionViewController") as? CountrySelectionViewController else { return }
        self.navigationController?.pushViewController(selectCountryViewController, animated: true)
    }
    

}
