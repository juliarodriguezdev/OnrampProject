//
//  DefaultLocation.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/3/20.
//

struct DefaultLocation: Codable {
    
    var city: String
    var country: String
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case country
    }
}
