//
//  UserLocation.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/3/20.
//
import Foundation

class UserLocation {

    var city: String
    var country: String
    
    init(city: String, country: String) {
        self.city = city
        self.country = country
        
    }
    
   /* init(_ jsonObject: DefaultLocation) {
        self.city = jsonObject.city
        self.country = jsonObject.country
    } */
    
}
extension UserLocation: Equatable {
    static func == (lhs: UserLocation, rhs: UserLocation) -> Bool {
        return lhs.city == rhs.city
            && lhs.country == rhs.country
    }
}
