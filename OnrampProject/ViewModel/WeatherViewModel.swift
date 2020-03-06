//
//  WeatherViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/2/20.
//

import UIKit

private let apiKey = "0a22a03c9a9015c59e9463a9bd2532aa"

class WeatherViewModel {
    
    var results: [WeatherDetails] = []
        
    let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast")
    
    func fetchFiveDayWeatherForecast(userPlace: String, completion: @escaping ([WeatherDetails]?)-> Void) {
        guard let url = baseURL else { completion(nil); return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let cityPlaceQuery = URLQueryItem(name: "q", value: userPlace)
        
        let unitsQuery = URLQueryItem(name: "units", value: "imperial")
        
        let apiKeyQuery = URLQueryItem(name: "appid", value: apiKey)
        
        components?.queryItems = [cityPlaceQuery, unitsQuery, apiKeyQuery]
        
        guard let finalURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion([])
                return
            }
            guard let data = data else { completion(nil); return }
            do {
                let jsonDecoder = JSONDecoder()
                let weatherTopLevelJSONResults = try jsonDecoder.decode(WeatherTopLevelJSON.self, from: data)
                self.results = weatherTopLevelJSONResults.list
                completion(weatherTopLevelJSONResults.list)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
                return
            }
        }.resume()
    }
    
    func loadWeatherDetails(place: String) {
        fetchFiveDayWeatherForecast(userPlace: place) { (foundResults) in
            if let fetchedWeather = foundResults {
                self.results = fetchedWeather
            }
        }
    }
    func todaysWeatherImage(weather: WeatherDetails) -> String {
        // results[first] passed in
        // TODO: add sad face cloud for no results
        return weather.weather.first?.icon ?? ""

    }
    func todaysWeatherTemp(weather: WeatherDetails) -> String {
        let temperatureInt = Int(weather.main.temp.rounded())
        return "\(temperatureInt)ºF"
    }
    
    func indexImageName(weather: WeatherDetails) -> String {
        let iconName = weather.weather.first?.icon ?? ""
        return iconName
    }
    
    func indexDescription(weather: WeatherDetails) -> String {
        let descripText = weather.weather.first?.description ?? ""
        return descripText
    }
    
    func indexTimeStamp(weather: WeatherDetails) -> String {
        let timeStamp = weather.timestampOfForecast
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let timeSnapshot = formatter.date(from: timeStamp) else { return ""}
        formatter.dateFormat = "h:mm a 'on' MMM d, yyyy"
        return formatter.string(from: timeSnapshot)
    }
    
    func indexTemperature(weather: WeatherDetails) -> String {
        let temp = Int(weather.main.temp.rounded())

        return "\(temp)ºF"
        
    }
}

