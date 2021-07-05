//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 02/07/21.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Public Properties
    var locationManager: CLLocationManager?
    let baseDataController = BaseDataController()
    var temperatureViewModel: CurrentTempViewModel?
    var sevenDaysVM = [CurrentTempViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupLocation()
    }

    func setupLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
    }

    // MARK: - IBAction
    @IBAction func submitBtnTapped() {
        if userNameTextField.text == "" {
            return
        }
        AppDelegate.username = userNameTextField.text!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabVC = storyboard.instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
        tabVC.configureModel(tempViewModel: self.temperatureViewModel, sevenDaysVM: sevenDaysVM)
        self.navigationController?.pushViewController(tabVC, animated: true)
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getWeatherDetails()
        NotificationCenter.default.post(name: Notification.Name(Notification_Name), object: nil, userInfo: ["currentTemp": self.temperatureViewModel, "sevenDaysTemp": self.sevenDaysVM])
    }
}

// MARK: - API Call
extension ViewController {
    func getWeatherDetails(){
        self.temperatureViewModel = nil
        self.sevenDaysVM.removeAll()
        let coordinates = locationManager?.location?.coordinate
        guard let lat = coordinates?.latitude, let long =  coordinates?.longitude else { return }
        baseDataController.fetchRequest(lat: String(lat), long: String(long))
        self.temperatureViewModel = CurrentTempViewModel(currentTempModel: baseDataController.temperatureModel?.current ?? CurrentTempModel(dictValues: ["": ""]))
        
        guard let dailyWeatherModel = baseDataController.temperatureModel?.dailyTemp else { return }
        for iterator in dailyWeatherModel {
            self.sevenDaysVM.append(CurrentTempViewModel(currentTempModel: iterator))
        }
    }
}
