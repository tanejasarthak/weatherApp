//
//  DateViewController.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 03/07/21.
//

import UIKit

class DateViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var selectCityTextField: UITextField!
    @IBOutlet weak var selectDateTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var minTempLabel: UILabel!
    
    // MARK: - Public Properties
    let cities = ["Delhi", "Mumbai", "Noida"]
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    let toolBarForPicker = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker))
    let toolBarForDatePicker = UIToolbar().ToolbarPiker(mySelect: #selector(dismissDatePicker))
    var selectedCity = ""
    var selectedDate = ""
    var selectedCityEnum: LatLonEnum?
    let baseDataController = BaseDataController()
    var sevenDaysVM: CurrentTempViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configurePickerView()
        configureDatePickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleUI()
    }
    
    func configurePickerView() {
        pickerView.delegate = self
        selectCityTextField.inputView = pickerView
        selectCityTextField.inputAccessoryView = toolBarForPicker
    }
    
    func configureDatePickerView() {
        selectDateTextField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        
        var dateComponents = calendar().1
        dateComponents.day = 7
        datePicker.maximumDate = calendar().0.date(byAdding: dateComponents, to: Date())!
      
        selectDateTextField.inputAccessoryView = toolBarForDatePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    func calendar() -> (Calendar, DateComponents) {
        let dateComponents = DateComponents()
        var cal = Calendar(identifier: Calendar.Identifier.gregorian)
        cal.timeZone = TimeZone(abbreviation: "UTC")!
        return (cal, dateComponents)
    }
    
    @objc func dismissPicker() {
        selectCityTextField.text = selectedCity
        self.view.endEditing(true)
    }

    @objc func dismissDatePicker() {
        self.view.endEditing(true)
    }
    
    func handleUI() {
        guard let sevenDaysVM = sevenDaysVM else { return }
        
        dataView.isHidden = false
        if AppDelegate.isCelsius {
            temperatureLabel.text = String(describing: kelvinToCelsius(tempInKelvin: sevenDaysVM.maxTemp)) + Celsius
            minTempLabel.text = String(describing: kelvinToCelsius(tempInKelvin: sevenDaysVM.minTemp)) + Celsius
        } else {
            temperatureLabel.text = String(describing: kelvinToFahrenheit(tempInKelvin: sevenDaysVM.maxTemp)) + Fahrenheit
            minTempLabel.text = String(describing: kelvinToFahrenheit(tempInKelvin: sevenDaysVM.minTemp)) + Fahrenheit
        }
        windSpeedLabel.text = String(describing: sevenDaysVM.wind_speed)
        feelLikeLabel.text = String(describing: sevenDaysVM.feels_like_arr)
        self.viewDidLoad()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
//        if let day = components.day, let month = components.month, let year = components.year {
//            selectDateTextField.text = String(day) + " / " + String(month) + " / " + String(year)
//        }
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        selectDateTextField.text =  formatter.string(from: sender.date)
        selectedDate = formatter.string(from: sender.date)
    }

    // MARK: - IBAction
    @IBAction func submitBtnTap(_ sender: Any) {
        let group = DispatchGroup()
        
        fetchData()
      //  handleUI()
    }
}

extension DateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = cities[row]
        selectedCityEnum = LatLonEnum(rawValue: selectedCity)
    }
}

extension DateViewController {
    func fetchData() {
        self.baseDataController.fetchRequest(lat: String(self.selectedCityEnum?.lattitude ?? 0.0), long: String(self.selectedCityEnum?.longitude ?? 0.0))
        NotificationCenter.default.addObserver(self, selector: #selector(performUIChange), name: Notification.Name("CallComp"), object: nil)
        performUIChange()
    }
    
    @objc func performUIChange() {
        guard let dailyWeatherModel = self.baseDataController.temperatureModel?.dailyTemp else { return }
        for iterator in dailyWeatherModel   {
            let tempDate = CurrentTempViewModel(currentTempModel: iterator).dateOfWeather
            if tempDate == self.selectedDate {
                self.sevenDaysVM = CurrentTempViewModel(currentTempModel: iterator)
                handleUI()
                break
            }
        }
    }
}
