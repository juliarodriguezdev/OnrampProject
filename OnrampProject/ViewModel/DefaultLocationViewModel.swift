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
            let fetchedLocations = locationResults.filter({$0.city != ""}).filter({$0.city != "-"}).compactMap{ $0.city + ", " + (NSLocale.current.localizedString(forRegionCode: $0.country) ?? "")}.sorted()
            self.locations = fetchedLocations
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
        }
    }
    
    func displaySearchResults(isSearching: Bool, searchText: String) -> [String] {
        var results = [String]()
        // if true
        
        if isSearching {
            var count = searchText.count
            let searchResults = locations.filter({$0.prefix(count).lowercased() == searchText}).sorted()
            results = searchResults
            

        } else {
            results = locations
        }
        return results
    }
    
    // CRUD

}
