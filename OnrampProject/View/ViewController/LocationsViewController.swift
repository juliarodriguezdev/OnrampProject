//
//  LocationsViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class LocationsViewController: UIViewController {
    
    // add view model
    let locationsViewModel = UserLocationViewModel()
    
    @IBOutlet weak var locationsTableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        updateUI()

    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        showCountrySelectionViewController()
    }
    
    func updateUI() {
        addButton.setTitle(locationsViewModel.buttonTitle, for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showCountrySelectionViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let countrySelectionViewController = storyboard.instantiateViewController(identifier: "CountrySelectionViewController") as? CountrySelectionViewController else { return }
        self.navigationController?.pushViewController(countrySelectionViewController, animated: true)
    }

}
extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsViewModel.savedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationsTableViewCell else { return UITableViewCell() }
        let location = locationsViewModel.savedLocations[indexPath.row]
        cell.locationLabel.text = "\(location.city), \(location.country)"
        
        return cell
        
    }
    
    
}
