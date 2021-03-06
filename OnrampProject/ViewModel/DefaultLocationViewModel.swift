//
//  DefaultLocationViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/3/20.
//

import UIKit

class DefaultLocationViewModel {
    
    var locations: [String] = []
    
    private var rawLocations: [DefaultLocation] = []
    
    private var finalRawLocations: [DefaultLocation] {
        return rawLocations.filter({$0.city != ""}).filter({$0.city != "-"})
    }
    
    private var usaLocations: [DefaultLocation] {
        return finalRawLocations.filter({$0.country == "US"})
    }
    
    private var internationLocations: [DefaultLocation] {
        return finalRawLocations.filter({$0.country != "US"})
    }
    
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
            self.rawLocations = locationResults
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
        }
    }
    
    func displaySearchResults(isSearching: Bool, inUSA: Bool, searchText: String) -> [String] {
        var results = [String]()
        let count = searchText.count
        
        if isSearching, inUSA {
            let criteriaResults = Array(Set(usaLocations.compactMap({$0.city})))
            let searchResults = criteriaResults.filter({$0.prefix(count).lowercased() == searchText}).sorted()
            results = searchResults
            
        } else if isSearching, !inUSA {
            let criteriaResults = Array(Set(internationLocations.compactMap({$0.city + ", " + (NSLocale.current.localizedString(forRegionCode: $0.country) ?? "")})))
            let searchResults = criteriaResults.filter({$0.prefix(count).lowercased() == searchText}).sorted()
            results = searchResults
        } else if !isSearching, inUSA {
            let criteriaResults = Array(Set(usaLocations.compactMap({$0.city}))).sorted()
            results = criteriaResults
            
        } else if !isSearching, !inUSA {
            let criteriaResults = Array(Set(internationLocations.compactMap({$0.city + ", " + (NSLocale.current.localizedString(forRegionCode: $0.country) ?? "")}))).sorted()
            results = criteriaResults
        }
        
        return results
    }
}
