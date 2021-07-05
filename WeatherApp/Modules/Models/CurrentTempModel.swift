//
//  CurrentTempModel.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 04/07/21.
//

import Foundation

struct CurrentTempModel {
    let visibility: Int?
    let feels_like: Double?
    let temp: Double?
    let sunset: String?
    let humidity: Int?
    let sunrise: String?
    let wind_speed: Double?
    let weather: [Any]?
    let feels_like_arr: [String: Any]?
    let temp_arr: [String: Any]?
    let date: String?
    
    init(dictValues: [String: Any]) {
        visibility = dictValues["visibility"] as? Int
        feels_like = dictValues["feels_like"] as? Double
        feels_like_arr = dictValues["feels_like"] as? [String: Any]
        temp = dictValues["temp"] as? Double
        temp_arr = dictValues["temp"] as? [String: Any]
        humidity = dictValues["humidity"] as? Int
        wind_speed = dictValues["wind_speed"] as? Double
        weather = dictValues["weather"] as? [Any]
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        date = formatter.string(from: Date(timeIntervalSince1970: dictValues["dt"] as? Double ?? 0.0))
        sunset = formatter.string(from: Date(timeIntervalSince1970: dictValues["sunset"] as? Double ?? 0.0))
        sunrise = formatter.string(from: Date(timeIntervalSince1970: dictValues["sunrise"] as? Double ?? 0.0))
    }
}
