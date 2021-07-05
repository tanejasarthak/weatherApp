//
//  BaseDataController.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 04/07/21.
//

import Foundation
import Alamofire

class BaseDataController {
    var temperatureModel: TemperatureModel?
    func fetchRequest(lat: String, long: String) {
        let url = getUrl(lat: lat, long: long)
        AF.request(url)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonVal = value as? [String: Any] {
                        self.temperatureModel = TemperatureModel(dictValues: jsonVal)
                        NotificationCenter.default.post(name: Notification.Name("CallComp"), object: nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
