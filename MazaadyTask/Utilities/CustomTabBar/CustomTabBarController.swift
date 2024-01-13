//
//  CustomTabBarController.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var coordinator: Coordinator!
    
    init(coordinator: Coordinator){
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(CustomTabBar(), forKey: "tabBar")
        setupTabBarItems()
        setupTabBarUI()
    }
    
    enum TabBarItems:Int, CaseIterable{
        case Home
        case Discover
        case Notification
        case Profile
    }

    private func setupTabBarUI(){
        self.tabBar.tintColor = DesignSystem.Colors.PrimaryRed.color
        self.tabBar.unselectedItemTintColor = DesignSystem.Colors.NeutralGray4.color
    }
    
    func viewControllerForTabBar(_ item: TabBarItems)-> UIViewController{
        switch item {
        case .Home:
            let view = coordinator.Main.viewController(for: .home)
            view.tabBarItem = tabBarItem(for: item)
            return view
        case .Discover:
            let vc = UIViewController()
            vc.tabBarItem = tabBarItem(for: item)
            return vc
        case .Notification:
            let vc = UIViewController()
            vc.tabBarItem = tabBarItem(for: item)
            return vc
        case .Profile:
            let vc = UIViewController()
            vc.tabBarItem = tabBarItem(for: item)
            return vc
        }
    }
    
    func setupTabBarItems(){
        self.viewControllers = TabBarItems.allCases.map({
            let viewController = viewControllerForTabBar($0)
            let navigation = UINavigationController(rootViewController: viewController)
            return navigation
            
        })
    }
    
    private func tabBarItem(for item: TabBarItems)-> UITabBarItem{
        let tabBarItem: UITabBarItem
        switch item {
        case .Home:
            tabBarItem = .init(title: "", image: UIImage(named: "home_tab_icon"), selectedImage: UIImage(named: "home_tab_icon"))
        case .Discover:
            tabBarItem = .init(title: "", image: UIImage(named: "discover_tab_icon"), selectedImage: UIImage(named: "discover_tab_icon"))
        case .Notification:
            tabBarItem = .init(title: "", image: UIImage(named: "notification_tab_icon"), selectedImage: UIImage(named: "notification_tab_icon"))
            tabBarItem.badgeValue = "2"
            tabBarItem.badgeColor = DesignSystem.Colors.PrimaryRed.color
        case .Profile:
            tabBarItem = .init(title: "", image: UIImage(named: "profile_tab_icon"), selectedImage: UIImage(named: "profile_tab_icon"))
        }
        tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 15)
        tabBarItem.imageInsets = .init(top: 10, left: 0, bottom: -10, right: 0)
        return tabBarItem
    }
    
}
