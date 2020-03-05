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
    
    var inUSA: Bool?
    
    var searchResults = [String]()
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTextField.delegate = self
        self.searchTextField.addTarget(self, action: #selector(searching), for: .touchDown)

    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        // get info from textfield
        guard let selectedLocation = searchTextField.text, !selectedLocation.isEmpty else {
            presentUIHelperAlert(title: "Missing Info", message: "Invalid loaction entry, please select a city, country")
            return
        }
        
        // create userLocation object to save to viewmodel
        let locationArray = selectedLocation.components(separatedBy: ", ")
        let city = locationArray[0]
        let country = locationArray[1]
        // verify source of truth gets updated
        userLocationsViewModel.createLocationWith(city: city, country: country)
        
        // push next view controller: show the main weather to display
        
        
    }
    
    @objc func searching(_ textField: UITextField) {
        isSearching = true
    }
    
    @objc func doneButtonAction() {
        searchTextField.resignFirstResponder()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        done.tintColor = .systemBlue
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        guard let searchText = textField.text?.lowercased(),
            let isInUSA = inUSA
            
            else { return }
        print("Textfield searchText is: \(searchText)")
        
        if searchText.isEmpty {
            isSearching = false
        } else if searchText.count >= 1 {
            isSearching = true
        }
        // populates when searching
        searchResults = defaultLocationsViewModel.displaySearchResults(isSearching: isSearching, inUSA: isInUSA, searchText: searchText)
        self.searchTableView.reloadData()
        
    }
}
