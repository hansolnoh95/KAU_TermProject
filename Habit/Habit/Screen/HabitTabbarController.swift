//
//  TabbarViewController.swift
//  Habit
//
//  Created by 노한솔 on 2021/09/28.
//

import UIKit

class HabitTabbarController: UITabBarController {
    
    var defaultIndex = 0 {
        didSet {
            self.selectedIndex = defaultIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.selectedIndex = defaultIndex
        self.tabBar.layer.borderWidth = 0
        //    self.tabBar.layer.borderColor = lineColor.cgColor
    }
    
}
extension HabitTabbarController : UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homeViewController = HomeViewController()
        let homeNavigationConroller =  UINavigationController(rootViewController: homeViewController)
        homeNavigationConroller.navigationBar.isHidden = true
        
        let clientViewController = ViewController()
        let clientNavigationController = UINavigationController(rootViewController: clientViewController)
        clientNavigationController.navigationBar.isHidden = true
        
        let routineViewController = ViewController()
        let routineNavigationController = UINavigationController(rootViewController: routineViewController)
        routineNavigationController.navigationBar.isHidden = true
        
        let calendarViewController = ViewController()
        let calendarNavigationController = UINavigationController(rootViewController: calendarViewController)
        calendarNavigationController.navigationBar.isHidden = true
        
        let myViewController = ViewController()
        let myNavigationController = UINavigationController(rootViewController: myViewController)
        myNavigationController.navigationBar.isHidden = true
        
        let viewControllers = [
            homeNavigationConroller,
            clientNavigationController,
            routineNavigationController,
            calendarNavigationController,
            myNavigationController
        ]
        
        self.setViewControllers(viewControllers, animated: true)
        
        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = UIColor.clear
        tabBar.barStyle = UIBarStyle.default
        tabBar.barTintColor = UIColor.white
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.setRounded(radius: 10.adjusted)
        
        let imageNames = [
            "tabHomeInact",
            "tabClientInact",
            "tabRoutineInact",
            "tabCalendarInact",
            "tabMyInact"
        ]
        
        let imageSelectedNames = [
            "tabHomeAct",
            "tabClientAct",
            "tabRoutineAct",
            "tabCalendarAct",
            "tabMyAct"
        ]
        
        for (index, value) in (tabBar.items?.enumerated())! {
            let tabBarItem: UITabBarItem = value as UITabBarItem
            tabBarItem.title = nil
            tabBarItem.image = UIImage(named: imageNames[index])?.withRenderingMode(.alwaysOriginal)
            tabBarItem.selectedImage = UIImage(named: imageSelectedNames[index])?.withRenderingMode(.alwaysOriginal)
            tabBarItem.accessibilityIdentifier = imageNames[index]
            tabBarItem.imageInsets.top = 15
            tabBarItem.imageInsets.bottom = -15
        }
    }
}
