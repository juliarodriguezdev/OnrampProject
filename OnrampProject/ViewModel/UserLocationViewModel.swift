//
//  LocationViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/2/20.
//

import UIKit

class LocationViewModel {
    // var to fill view controller content
    
    // MARK: - source of truth
    var savedLocations: [UserLocation] = [] {
        didSet {
            print("savedLocations has changed, notify delegate")
        }
    }
    
    private let userDefaults = UserDefaults.standard
    
    private init() {
        fetchLocations()
    }
    
    // MARK: - Create a location
    func createLocationWith(city: String, country: String) {
       // let newLocation = Location(city: city, country: country)
        //savedLocations.append(newLocation)
        saveToUserDefaults()
        
    }
    
    // MARK: - Read/Fetch a location
    func fetchLocations() {
        //let userLocations = userDefaults.array(forKey: LocationKeys.userLocationsKey) as? [UserLocation] ?? [Location]()
        
        //savedLocations = userLocations
    }
    
    // MARK: - Update a location
    func updateLocationAt(location: UserLocation, city: String, country: String) {
        if let indexToUpdate = savedLocations.firstIndex(of: location) {
            print(indexToUpdate)
            //savedLocations[indexToUpdate].city = city
            //savedLocations[indexToUpdate].country = country
            
            saveToUserDefaults()
            print("savedLocations after update: \(savedLocations)")
        }
    }
    
    // MARK: - Delete a location
    func deleteSingleLocationAt(selectedLocation: UserLocation) {
        
            if let index = savedLocations.firstIndex(of: selectedLocation) {
                print(index)

                savedLocations.remove(at: index)
                saveToUserDefaults()
            }
    }
    
    func deleteAllLocations() {
        userDefaults.removeObject(forKey: LocationKeys.userLocationsKey)
        // TODO test after this is removed if it saves it
        print(savedLocations)
        
    }
    
    // MARK: - Persist data with user defaults
    func saveToUserDefaults() {
        userDefaults.set(savedLocations, forKey: LocationKeys.userLocationsKey)
        
    }
    
}
// MARK: Keys
struct LocationKeys {
    static let userLocationsKey = "userSavedLocations"
}
