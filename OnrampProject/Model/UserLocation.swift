//
//  UserLocation.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/3/20.
//
import Foundation

class UserLocation {

    var city: String
    var place: String
    var joinedLocation: String {
        return city + ", " + place
    }
    
    
    init(city: String, place: String) {
        self.city = city
        self.place = place
    }
}

extension UserLocation: Equatable {
    static func == (lhs: UserLocation, rhs: UserLocation) -> Bool {
        return lhs.city == rhs.city
            && lhs.place == rhs.place
    }
}
