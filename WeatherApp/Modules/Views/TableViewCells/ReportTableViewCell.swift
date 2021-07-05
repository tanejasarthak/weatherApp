//
//  ReportTableViewCell.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 04/07/21.
//

import UIKit

class ReportTableViewCell: UITableViewCell {
        
    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    
    var sevenDaysVM: CurrentTempViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(sevenDaysVM: CurrentTempViewModel?) {
        guard let sevenDaysVM = sevenDaysVM else { return }
        self.sevenDaysVM = sevenDaysVM
        setupView()
    }
    
    func setupView() {
        guard let sevenDaysVM = sevenDaysVM else { return }
        dateLabel.text = String(describing: sevenDaysVM.dateOfWeather)
        if AppDelegate.isCelsius {
            maxTempLabel.text = String(describing: kelvinToCelsius(tempInKelvin: sevenDaysVM.maxTemp)) + Celsius
            minTempLabel.text = String(describing: kelvinToCelsius(tempInKelvin: sevenDaysVM.minTemp)) + Celsius
            feelsLikeLabel.text = String(describing: kelvinToCelsius(tempInKelvin: sevenDaysVM.feels_like_arr)) + Celsius
        } else {
            maxTempLabel.text = String(describing: kelvinToFahrenheit(tempInKelvin: sevenDaysVM.maxTemp)) + Fahrenheit
            minTempLabel.text = String(describing: kelvinToFahrenheit(tempInKelvin: sevenDaysVM.minTemp)) + Fahrenheit
            feelsLikeLabel.text = String(describing: kelvinToFahrenheit(tempInKelvin: sevenDaysVM.feels_like_arr)) + Fahrenheit
        }
        windspeedLabel.text = String(describing: sevenDaysVM.wind_speed)
    }
}
