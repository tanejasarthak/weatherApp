//
//  TemperatureModel.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 04/07/21.
//

import Foundation

struct TemperatureModel {
    
    let current: CurrentTempModel?
    let daily: [[String: Any]]?
    var dailyTemp = [CurrentTempModel]()
    
    init(dictValues: [String: Any]) {
        current = CurrentTempModel(dictValues: dictValues["current"] as? [String: Any] ?? ["": ""])
        daily = dictValues["daily"] as? [[String: Any]]
        guard let daily = daily else { return }
        for iterator in daily {
            dailyTemp.append(CurrentTempModel(dictValues: iterator))
        }
    }
}
