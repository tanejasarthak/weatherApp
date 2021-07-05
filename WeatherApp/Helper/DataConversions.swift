//
//  DataConversions.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 04/07/21.
//

import Foundation

func kelvinToCelsius(tempInKelvin: Double) -> Int {
    return Int(tempInKelvin - 273.15)
}

func kelvinToFahrenheit(tempInKelvin: Double) -> Int {
    return Int((tempInKelvin - 273.15) * 1.8 + 32)
}
