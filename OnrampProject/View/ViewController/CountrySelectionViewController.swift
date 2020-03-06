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
    
    @IBOutlet weak var continueButton: UIButton!
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    
