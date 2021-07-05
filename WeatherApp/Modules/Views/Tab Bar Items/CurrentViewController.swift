//
//  CurrentViewController.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 03/07/21.
//

import UIKit

class CurrentViewController: UIViewController {

    @IBOutlet weak var currentDateTextField: UILabel!
    @IBOutlet weak var windspeedTextField: UILabel!
    @IBOutlet weak var feelsLikeTextField: UILabel!
    @IBOutlet weak var humidityTextField: UILabel!
    @IBOutlet weak var sunriseTextField: UILabel!
    @IBOutlet weak var sunsetTextField: UILabel!
    @IBOutlet weak var usernameTextField: UILabel!
    @IBOutlet weak var temperatureTextField: UILabel!
    
    var viewModel: CurrentTempViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handleNotifications()
        usernameTextField.text = "Hi " + AppDelegate.username!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    func configureModel(tempVM: CurrentTempViewModel?) {
        guard let tempVM = tempVM else { return }
        self.viewModel = tempVM
    }
    
    func handleNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notification.Name(Notification_Name), object: nil)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        viewModel = notification.userInfo?["currentTemp"] as? CurrentTempViewModel
        configureView()
        self.view.setNeedsLayout()
    }
    
    func configureView() {
        guard let viewModel = viewModel else { return }
        currentDateTextField.text = String(describing: viewModel.currentDataModel.date ?? "")
        windspeedTextField.text = String(describing: viewModel.currentDataModel.wind_speed ?? 0.0)
        if AppDelegate.isCelsius {
            feelsLikeTextField.text = String(describing: kelvinToCelsius(tempInKelvin: viewModel.currentDataModel.feels_like ?? 0)) + Celsius
            temperatureTextField.text = String(describing: kelvinToCelsius(tempInKelvin: viewModel.currentDataModel.temp ?? 0)) + Celsius
        } else {
            feelsLikeTextField.text = String(describing: kelvinToFahrenheit(tempInKelvin: viewModel.currentDataModel.feels_like ?? 0.0)) + Fahrenheit
            temperatureTextField.text = String(describing: kelvinToFahrenheit(tempInKelvin: viewModel.currentDataModel.temp ?? 0.0)) + Fahrenheit
        }
        humidityTextField.text = String(describing: viewModel.currentDataModel.humidity ?? 0)
        sunriseTextField.text = String(describing: viewModel.currentDataModel.sunrise ?? "")
        sunsetTextField.text = String(describing: viewModel.currentDataModel.sunset ?? "")
    }
}

