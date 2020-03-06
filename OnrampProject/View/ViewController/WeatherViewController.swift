//
//  WeatherViewController.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/5/20.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let weatherViewModel = WeatherViewModel()
    
    // landing pad
    var userPlace: String?
        
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var todaysWeatherImage: UIImageView!
    
    @IBOutlet weak var todaysTempLabel: UILabel!
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    @IBOutlet weak var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        HelperUI.configShadowForView(viewName: backgroundView, cornerRadius: 25, shadowRadius: 15)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let place = userPlace else { return }
        placeLabel.text = place
        weatherViewModel.fetchFiveDayWeatherForecast(userPlace: place) { (weatherResults) in
            if weatherResults != nil {
                DispatchQueue.main.async {
                    self.updateTodaysWeather()
                    self.weatherTableView.reloadData()
                }
            }
        }
        //weatherViewModel.loadWeatherDetails(place: place)
    }
    
    func updateTodaysWeather() {
        if let todaysWeather = weatherViewModel.results.first {
            let iconStringName = weatherViewModel.todaysWeatherImage(weather: todaysWeather)
            
            todaysWeatherImage.image = UIImage(named: iconStringName)
            todaysTempLabel.text = weatherViewModel.todaysWeatherTemp(weather: todaysWeather)
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        showUserPlacesViewController()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showUserPlacesViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let userPlacesViewController = storyboard.instantiateViewController(identifier: "UserLocationsViewController") as? UserLocationsViewController else { return }
        // TODO: check if its on the stack, if so for loop to VC, pop to existing VC on stack
        self.navigationController?.pushViewController(userPlacesViewController, animated: true)
    }

}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        let weather = weatherViewModel.results[indexPath.row]
        
        cell.weatherIcon.image = UIImage(named: weatherViewModel.indexImageName(weather: weather))
    
        cell.descriptionLabel.text = weatherViewModel.indexDescription(weather: weather)
        cell.timeDateLabel.text = weatherViewModel.indexTimeStamp(weather: weather)
        cell.temperatureLabel.text = weatherViewModel.indexTemperature(weather: weather)
        
        return cell
        
    }
    
    
}
