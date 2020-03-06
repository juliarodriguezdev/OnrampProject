//
//  DefaultLocationsViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class DefaultLocationsViewController: UIViewController {
    
    let defaultLocationsViewModel = DefaultLocationViewModel()
    let userLocationsViewModel = UserLocationViewModel()
    
    var isSearching = false
    
    var userSelectedFromList = false
    
    var inUSA: Bool?
        
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var confirmButton: OrangeButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTextField.delegate = self
        self.searchTextField.addTarget(self, action: #selector(searching), for: .touchDown)
        self.addDoneButtonOnKeyboard()
        updateUI()

    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        // get info from textfield
        guard let selectedLocation = searchTextField.text, !selectedLocation.isEmpty, userSelectedFromList else {
            presentUIHelperAlert(title: "Invalid Entry", message: "Invalid location entry, please select from the provided locations")
            searchTextField.text = ""
            return
        }
        if inUSA == true {
            showStatesViewController(userCity: selectedLocation)
        
        } else {
            // create userLocation object to save to viewmodel
            let locationArray = selectedLocation.components(separatedBy: ", ")
            let city = locationArray[0]
            let country = locationArray[1]
            // verify source of truth gets updated
            userLocationsViewModel.createLocationWith(city: city, place: country)
            let userSelectedPlace = userLocationsViewModel.generateUserPlaceString(city: city, place: country)
            // push next view controller: show the main weather to display
            showWeatherResultsViewController(userPlace: userSelectedPlace )
        }
    }
    
    @objc func searching(_ textField: UITextField) {
        isSearching = true
    }
    
    @objc func doneButtonAction() {
        searchTextField.resignFirstResponder()
    }
    
    func updateUI() {
        confirmButton.setTitle(HelperUI.init().continueText, for: .normal)
        searchTextField.placeholder = HelperUI.init().placeholderText
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        done.tintColor = UIColor.customLightOrange
        let items = [flexibleSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        searchTextField.inputAccessoryView = doneToolbar
    }
    
    func presentUIHelperAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true)
    }
    
    func showStatesViewController(userCity: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let stateSelectionViewController = storyboard.instantiateViewController(identifier: "StatesViewController") as? StatesViewController else { return }
        stateSelectionViewController.selectedCity = userCity
        self.navigationController?.pushViewController(stateSelectionViewController, animated: true)
    }
    
    func showWeatherResultsViewController(userPlace: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let weatherResultsViewController = storyboard.instantiateViewController(identifier: "WeatherViewController") as? WeatherViewController else { return }
        weatherResultsViewController.userPlace = userPlace
        self.navigationController?.pushViewController(weatherResultsViewController, animated: true)
        
    }
}

extension DefaultLocationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        let searchText = searchTextField.text?.lowercased()
        
        if let checkForUSA = inUSA {
            let results = defaultLocationsViewModel.displaySearchResults(isSearching: isSearching, inUSA: checkForUSA, searchText: searchText ?? "")
            count = results.count
        }
            
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultLocationCell", for: indexPath)
        var locationToDisplay: String?
        let searchText = searchTextField.text?.lowercased()
        
        if let checkForUSA = inUSA {
            let results = defaultLocationsViewModel.displaySearchResults(isSearching: isSearching, inUSA: checkForUSA, searchText: searchText ?? "")
            locationToDisplay = results[indexPath.row]

        }
        
        cell.textLabel?.text = locationToDisplay
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        guard let locationText = cell?.textLabel?.text, !locationText.isEmpty else { return }
        searchTextField.text = locationText
        userSelectedFromList = true
        print("didSelectRowAt: \(locationText)")
        searchTextField.resignFirstResponder()
    }
}

extension DefaultLocationsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let searchText = textField.text?.lowercased()
            
            else { return }
        print("Textfield searchText is: \(searchText)")
        
        if searchText.isEmpty {
            isSearching = false
            userSelectedFromList = false
        } else {
            isSearching = true
        }
        self.searchTableView.reloadData()
        
    }
}
