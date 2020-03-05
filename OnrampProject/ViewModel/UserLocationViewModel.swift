//
//  UserLocationViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/2/20.
//

import UIKit

class UserLocationViewModel {
    // var to fill view controller content
    
    // MARK: - source of truth
    var savedLocations: [UserLocation] = [] {
        didSet {
            print("savedLocations has changed, notify delegate")
        }
    }
    
    init() {
        loadFromPersistnetStore()
    }
    
    // MARK: - Create a location
    func createLocationWith(city: String, country: String) {
       let newLocation = UserLocation(city: city, country: country)
       savedLocations.append(newLocation)
       saveToPersistentStore()
        
    }
    
    
    // MARK: - Update a location
    func updateLocationAt(location: UserLocation, newCityName: String, newCountryName: String) {
        if let indexToUpdate = savedLocations.firstIndex(of: location) {
            print(indexToUpdate)
            savedLocations[indexToUpdate].city = newCityName
            savedLocations[indexToUpdate].country = newCountryName
            
            saveToPersistentStore()
            print("savedLocations after update: \(savedLocations)")
        }
    }
    
    // MARK: - Delete a location
    func deleteSingleLocationAt(selectedLocation: UserLocation) {
        
            if let index = savedLocations.firstIndex(of: selectedLocation) {
                print(index)
                savedLocations.remove(at: index)
                saveToPersistentStore()
            }
    }
    
    // MARK: - Persist data with user defaults
    func saveToPersistentStore() {
        UserDefaults.userDefaultsObject.set(savedLocations, forKey: UserDefaultKeys.userLocationsKey)
        
    }
    // MARK: - Read/Fetch a location
    func loadFromPersistnetStore() {
        let userLocations = UserDefaults.userDefaultsObject.array(forKey: UserDefaultKeys.userLocationsKey) as? [UserLocation] ?? [UserLocation]()
        savedLocations = userLocations
        
    }
    
    // might not be needed, verify UI 
    func deletePersistentStore() {
        UserDefaults.userDefaultsObject.removeObject(forKey: UserDefaultKeys.userLocationsKey)
        // TODO: - test after this is removed if it saves it
        print(savedLocations)
        
    }
    
    
}

