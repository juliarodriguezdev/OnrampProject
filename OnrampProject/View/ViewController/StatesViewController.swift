//
//  StatesViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/5/20.
//

import UIKit

class StatesViewController: UIViewController {
    
    let statesViewModel = StatesViewModel()
    let userLocationsViewModel = UserLocationViewModel()
    
    var isSearching = false
    
    var selectedCity: String?
    
    @IBOutlet weak var statesLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var statesTableView: UITableView!
    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statesTableView.delegate = self
        statesTableView.dataSource = self
        searchTextField.delegate = self
        self.searchTextField.addTarget(self, action: #selector(searching), for: .touchDown)
        self.addDoneButtonOnKeyboard()

    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        
        if let cityName = selectedCity,
            let stateSearchText = searchTextField.text, !stateSearchText.isEmpty {
            userLocationsViewModel.createLocationWith(city: cityName, place: stateSearchText)
            // push to weather view controller
        } else {
            presentUIHelperAlert(title: "Missing Info", message: "Please select a state, and try again")
            return
        }
    }
    
    @objc func searching(_ textfield: UITextField) {
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

extension StatesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let searchText = searchTextField.text?.lowercased() else { return }
        
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
        }
        self.statesTableView.reloadData()
    }
}

extension StatesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let searchText = searchTextField.text?.lowercased()
        
        let results = statesViewModel.dispayStatesSearchResults(isSearching: isSearching, searchText: searchText ?? "")
        
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        
        let searchText = searchTextField.text?.lowercased()
        
        let results = statesViewModel.dispayStatesSearchResults(isSearching: isSearching, searchText: searchText ?? "")
        let stateToDisplay = results[indexPath.row]
        cell.textLabel?.text = stateToDisplay
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        guard let stateText = cell?.textLabel?.text, !stateText.isEmpty else { return }
        searchTextField.text = stateText
        searchTextField.resignFirstResponder()
    }

}
