//
//  DefaultLocationViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/3/20.
//

import Foundation

class DefaultLocationViewModel {
    
    // add singleton here or at ViewController, create an instance of viewmodel
    
    //source of truth
    var locations: [String] = []
    
    var filePath = Bundle.main.url(forResource: "city.list", withExtension: "json")
    
    init() {
        loadFromPersistentStorage()
    }
    
    func loadFromPersistentStorage() {
        guard let filePathURL = filePath else { return }
        
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: filePathURL)
            let locationResults = try decoder.decode([DefaultLocation].self, from: data)
            let fetchedLocations = locationResults.compactMap{ $0.city + ", " + $0.country}
            self.locations = fetchedLocations
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
        }
    }
    
    // CRUD

}
