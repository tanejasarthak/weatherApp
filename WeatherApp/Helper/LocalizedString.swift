//
//  LocalizedString.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 04/07/21.
//

import Foundation

let API_KEY = "8a684f5857021af88064bebbb4b14678"
let Notification_Name = "PassCurrentLocationNotification"
let Celsius = "°C"
let Fahrenheit = "°F"
let Delhi_Lat = 28.7041
let Delhi_Lon = 77.1025
let Mumbai_Lat = 19.0760
let Mumbai_Lon = 72.8777
let Noida_Lat = 28.5355
let Noida_Lon = 77.3910

func getUrl(lat: String, long: String) -> URL {
    return URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=hourly,minutely,alerts&appid=\(API_KEY)") ?? URL(string: "")!
}
