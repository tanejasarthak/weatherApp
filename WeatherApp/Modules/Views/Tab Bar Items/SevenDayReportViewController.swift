//
//  SevenDayReportViewController.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 03/07/21.
//

import UIKit

class SevenDayReportViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var reportTableView: UITableView!
    
    var viewModel: CurrentTempViewModel?
    var sevenDaysVM: [CurrentTempViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableView()
        usernameLabel.text = "Hi " + AppDelegate.username!
        handleNotifications()
        reportTableView.delegate = self
        reportTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.reportTableView.reloadData()
        }
    }
    
    func registerTableView() {
        reportTableView.tableFooterView = UIView()
        reportTableView.register(UINib(nibName: "ReportTableViewCell", bundle: nil), forCellReuseIdentifier: "ReportTableViewCell")
    }
    
    func configureModel(sevenDaysVM: [CurrentTempViewModel]?) {
        guard let tempVM = sevenDaysVM else { return }
        self.sevenDaysVM = tempVM
    }
    
    func handleNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notification.Name(Notification_Name), object: nil)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        sevenDaysVM = notification.userInfo?["sevenDaysTemp"] as? [CurrentTempViewModel]
        DispatchQueue.main.async {
            self.reportTableView.reloadData()
        }
    }
}

// MARK: - UITableView Delegate and Datasource
extension SevenDayReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sevenDaysVM?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportTableViewCell", for: indexPath) as? ReportTableViewCell
        cell?.configureCell(sevenDaysVM: sevenDaysVM?[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
