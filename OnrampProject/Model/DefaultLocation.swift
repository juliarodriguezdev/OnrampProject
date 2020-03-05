//
//  DefaultLocation.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/3/20.
//

struct DefaultLocation: Codable {
    
    var city: String
    var country: String
    var coord: Coord
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case country
        case coord
    }
}

struct Coord: Codable {
    var lon: Double
    var lat: Double
    
    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
}
