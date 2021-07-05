//
//  TemperatureViewModel.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 04/07/21.
//

import Foundation

struct CurrentTempViewModel {
    var currentDataModel: CurrentTempModel
   // var sevenDaysModel: [CurrentTempModel]?

    init(currentTempModel: CurrentTempModel) {
        self.currentDataModel = currentTempModel
     //   self.sevenDaysModel = tempModel.dailyTemp
    }
    
    var visibility: Int {
        return currentDataModel.visibility ?? 0
    }
    
    var feels_like: Double {
        return currentDataModel.feels_like ?? 0.0
    }
    
    var feels_like_arr: Double {
        return currentDataModel.feels_like_arr?["day"] as! Double
    }
    
    var maxTemp: Double {
        return currentDataModel.temp_arr?["max"] as! Double
    }
    
    var minTemp: Double {
        return currentDataModel.temp_arr?["min"] as! Double
    }
    
    var temperature: Double {
        return currentDataModel.temp ?? 0.0
    }
    
    var sunset: String {
        return currentDataModel.sunset ?? ""
    }
    
    var humidity: Int {
        return currentDataModel.humidity ?? 0
    }
    
    var sunrise: String {
        return currentDataModel.sunrise ?? ""
    }
    
    var wind_speed: Double {
        return currentDataModel.wind_speed ?? 0.0
    }
    
    var weather: [Any] {
        return currentDataModel.weather ?? [""]
    }
    
    var dateOfWeather: String {
        return currentDataModel.date ?? ""
    }
}
