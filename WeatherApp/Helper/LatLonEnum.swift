//
//  LatLonEnum.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 04/07/21.
//

import Foundation

enum LatLonEnum: String {
    case delhi = "Delhi"
    case mumbai = "Mumbai"
    case noida = "Noida"
    
    var lattitude: Double {
        switch self {
        case .delhi:
            return Delhi_Lat
        case .mumbai:
            return Mumbai_Lat
        case .noida:
            return Noida_Lat
        }
    }
    
    var longitude: Double {
        switch self {
        case .delhi:
            return Delhi_Lon
        case .mumbai:
            return Mumbai_Lon
        case .noida:
            return Noida_Lon
        }
    }
}
