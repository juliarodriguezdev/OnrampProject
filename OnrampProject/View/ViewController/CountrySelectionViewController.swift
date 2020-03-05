//
//  CountrySelectionViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

protocol CountryViewControllerDelegate: class {
    func updateCountrySelection(sender: CountrySelectionViewController, isUSA: Bool)
}

class CountrySelectionViewController: UIViewController {
    
    let countryViewModel = CountrySelectionViewModel()
    
    weak var delegate: CountryViewControllerDelegate?
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    @IBOutlet weak var selectionSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    }
    
    func updateUI() {
        selectionLabel.text = countryViewModel.message
        selectionSegmentedControl.setTitle(countryViewModel.segmentZero, forSegmentAt: 0)
        selectionSegmentedControl.setTitle(countryViewModel.segmentOne, forSegmentAt: 1)
        continueButton.setTitle(countryViewModel.buttonTitle, for: .normal)
    }
    
    func updateCountrySelection() {
        if selectionSegmentedControl.selectedSegmentIndex == 0 {
            delegate?.updateCountrySelection(sender: self, isUSA: true)
            print("Delegate: Country is USA")
        } else {
            delegate?.updateCountrySelection(sender: self, isUSA: false)
            print("Delegate: Country is Interational")
        }
        
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
    
