//
//  HomeTabBarController.swift
//  WeatherApp
//
//  Created by Sarthak Taneja on 03/07/21.
//

import UIKit

class HomeTabBarController: UITabBarController {

    //MARK: - Public Properties
    var tempViewModel: CurrentTempViewModel?
    var sevenDaysVM: [CurrentTempViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    //    self.tabBarController?.delegate = self
        configureTabBarItems()
    }
    
    func configureModel(tempViewModel: CurrentTempViewModel?, sevenDaysVM: [CurrentTempViewModel]?) {
        guard let tempViewModel = tempViewModel, let sevenDaysVM = sevenDaysVM else { return }
        self.tempViewModel = tempViewModel
        self.sevenDaysVM = sevenDaysVM
    }
    
    func configureTabBarItems() {
        let firstTabItem = self.viewControllers![0] as? CurrentViewController
        firstTabItem?.configureModel(tempVM: self.tempViewModel)
        
        let thirdTabItem = self.viewControllers![2] as? SevenDayReportViewController
        thirdTabItem?.configureModel(sevenDaysVM: self.sevenDaysVM)
    }
}

//extension HomeTabBarController: UITabBarControllerDelegate {
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        configureTabBarItems()
//    }
//}
