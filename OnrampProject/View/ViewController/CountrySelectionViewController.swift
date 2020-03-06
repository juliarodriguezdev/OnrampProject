//
//  CountrySelectionViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class CountrySelectionViewController: UIViewController {
    
    let countryViewModel = CountrySelectionViewModel()
        
    @IBOutlet weak var selectionLabel: UILabel!
    
    @IBOutlet weak var selectionSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var continueButton: OrangeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // default
        selectionSegmentedControl.selectedSegmentIndex = 0
        updateCountrySelection()
    }
    
    @IBAction func selectionChanged(_ sender: Any) {
        updateCountrySelection()
        
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        showDefaultLocationsViewController()
    }
    
    func updateUI() {
        selectionLabel.text = countryViewModel.message
        selectionSegmentedControl.setTitle(countryViewModel.segmentZero, forSegmentAt: 0)
        selectionSegmentedControl.setTitle(countryViewModel.segmentOne, forSegmentAt: 1)
        continueButton.setTitle(countryViewModel.buttonTitle, for: .normal)
        let avenirSizedFont = UIFont(name: FontNames.avenirBook, size: 15)
        selectionSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: avenirSizedFont!], for: .normal)
        selectionSegmentedControl.setTitle(countryViewModel.segmentZero, forSegmentAt: 0)
        selectionSegmentedControl.setTitle(countryViewModel.segmentOne, forSegmentAt: 1)
    }
    
    func updateCountrySelection() {
        if selectionSegmentedControl.selectedSegmentIndex == 0 {
            countryViewModel.updateCountryModelSelection(isInUSA: true)
            print("Delegate: Country is USA")
        } else {
            countryViewModel.updateCountryModelSelection(isInUSA: false)
            print("Delegate: Country is Interational")
        }
    }
    
    func showDefaultLocationsViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let defaultLocationsViewController = storyboard.instantiateViewController(identifier: "DefaultLocationsViewController") as? DefaultLocationsViewController else { return }
        defaultLocationsViewController.inUSA = countryViewModel.fetchIsUSASelected()
        self.navigationController?.pushViewController(defaultLocationsViewController, animated: true)
    }

}
    
