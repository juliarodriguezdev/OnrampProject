//
//  UserLocationsViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class UserLocationsViewController: UIViewController {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        showCountrySelectionViewController()
    }
    
    func updateUI() {
        addButton.setTitle(locationsViewModel.buttonTitle, for: .normal)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = locationsTableView.indexPathForSelectedRow,
            let destinationVC = segue.destination as? WeatherViewController else { return }
        let userLocation = locationsViewModel.userPlaces[index.row]
        destinationVC.userPlace = userLocation
        
    }

    
    func showCountrySelectionViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let countrySelectionViewController = storyboard.instantiateViewController(identifier: "CountrySelectionViewController") as? CountrySelectionViewController else { return }
        self.navigationController?.pushViewController(countrySelectionViewController, animated: true)
    }

}
extension UserLocationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsViewModel.userPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? UserLocationsTableViewCell else { return UITableViewCell() }
        let location = locationsViewModel.userPlaces[indexPath.row]
        //cell.place = location
        cell.loadTemperatureData(withPlace: location)
        cell.locationLabel.text = location
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = locationsViewModel.userPlaces[indexPath.row]
            locationsViewModel.deleteSingleLocationAt(selectedLocation: location)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
