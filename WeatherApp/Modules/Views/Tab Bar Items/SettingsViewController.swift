//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 03/07/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameLabel.text = "Hi " + AppDelegate.username!
    }
    
    @IBAction func segmentedAction() {
        if segmentedControl.selectedSegmentIndex == 1 {
            AppDelegate.isCelsius = false
        } else {
            AppDelegate.isCelsius = true
        }
    }
}
