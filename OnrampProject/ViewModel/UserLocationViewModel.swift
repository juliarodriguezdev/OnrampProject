//
//  UserLocationViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/2/20.
//

import UIKit

class UserLocationViewModel {
    
    let defaults = UserDefaults.standard
    
    var userPlaces: [String] = []
    
    init() {
        loadFromPersistnetStore()
    }
    
    // MARK: - Create a location
    func createLocationWith(city: String, place: String) {
        let newLocation = UserLocation(city: city, place: place)
        let joinedPlace = newLocation.joinedLocation
        userPlaces.append(joinedPlace)
        saveToPersistentStore()
        
    }
    
    
    // MARK: - Delete a location
    func deleteSingleLocationAt(selectedLocation: String) {
        
        guard let index = userPlaces.firstIndex(of: selectedLocation) else { return }
        print(index)
        userPlaces.remove(at: index)
        saveToPersistentStore()
        
    }
    
    // MARK: - Persist data with user defaults
    func saveToPersistentStore() {
        defaults.set(userPlaces, forKey: UserDefaultKeys.userLocationsKey)
        
    }
    // MARK: - Read/Fetch a location
    func loadFromPersistnetStore() {
        
        let userFetchedPlaces = defaults.object(forKey: UserDefaultKeys.userLocationsKey) as? [String] ?? [String]()
        userPlaces = userFetchedPlaces
        
    }
    
    // might not be needed, verify UI
    func deletePersistentStore() {
        defaults.removeObject(forKey: UserDefaultKeys.userLocationsKey)
        // TODO: - test after this is removed if it saves it
        print(userPlaces)
        
    }
    
    func generateUserPlaceString(city: String, place: String) -> String {
        return "\(city), \(place)"
    }
    
}

