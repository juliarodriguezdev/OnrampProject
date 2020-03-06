//
//  UserLocationsTableViewCell.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class UserLocationsTableViewCell: UITableViewCell {
    
   // var place: String?
    
    let weatherViewModel = WeatherViewModel()
    
    @IBOutlet weak var colorStripView: UIView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        HelperUI.configShadowForView(viewName: colorStripView, cornerRadius: 2, shadowRadius: 4)
    }
    
    func loadTemperatureData(withPlace: String) {
        weatherViewModel.fetchFiveDayWeatherForecast(userPlace: withPlace) { (weatherResults) in
            if weatherResults != nil {
                DispatchQueue.main.async {
                    if let todaysWeather = self.weatherViewModel.results.first {
                        self.temperatureLabel.text = self.weatherViewModel.todaysWeatherTemp(weather: todaysWeather)
                        let weatherIcon = self.weatherViewModel.indexImageName(weather: todaysWeather)
                        
                        switch weatherIcon {
                    
                        // orange
                        case "01d":
                            self.colorStripView.backgroundColor = UIColor.customOrange
                        // light orange
                        case "02d":
                            self.colorStripView.backgroundColor = UIColor.customLightOrange
                        // light blue
                        case "02n", "04d", "04n":
                            self.colorStripView.backgroundColor = UIColor.customLightBlue
                        // clear blue (bright)
                        case "03d", "03n":
                            self.colorStripView.backgroundColor = UIColor.customBrightBlue
                        // darkish blue
                        case "09d", "09n":
                            self.colorStripView.backgroundColor = UIColor.customOpaqueBlue
                        // light light orange
                        case "10d":
                            self.colorStripView.backgroundColor = UIColor.customVeryLightOrange
                        // light light blue
                        case "10n":
                            self.colorStripView.backgroundColor = UIColor.customVeryLightBlue
                        // light gray - thunder
                        case "11d", "11n":
                            self.colorStripView.backgroundColor = UIColor.customThunderGray
                        // gray / night time 
                        case "01n","13d", "13n", "50d", "50n":
                            self.colorStripView.backgroundColor = UIColor.customNightGray
                            
                        default:
                            print("No icon to set color")
                        }
                    }
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
