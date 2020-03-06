//
//  UserLocation.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/3/20.
//
import UIKit

class UserLocation {

    var city: String
    var place: String
    var joinedLocation: String {
        return city + ", " + place
    }
    let buttonTitle: String
    let placeholderText: String
    
    
    init(city: String, place: String, buttonTitle: String = "Add", placeholderText: String = "Start typing city here...") {
        self.city = city
        self.place = place
        self.buttonTitle = buttonTitle
        self.placeholderText = placeholderText
    }
}

extension UserLocation: Equatable {
    static func == (lhs: UserLocation, rhs: UserLocation) -> Bool {
        return lhs.city == rhs.city
            && lhs.place == rhs.place
    }
}
