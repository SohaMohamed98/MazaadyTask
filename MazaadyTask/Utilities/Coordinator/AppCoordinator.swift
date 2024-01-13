//
//  AppCoordinator.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var Main: MainNavigator {get}
    var selectedNavigationController: UINavigationController? {get}

}

class AppCoordinator: Coordinator{
    var navigationController: UINavigationController?
    
   
    var window: UIWindow
    lazy var Main: MainNavigator  = {
        return .init(coordinator: self)
    }()
     var selectedNavigationController: UINavigationController? {
         navController.navigationBar.isHidden = true
         return navController
    }
    
    var navController = UINavigationController() {
        didSet{
            navController.navigationBar.isHidden = true
        }
    }
    
    init(window: UIWindow = UIWindow()) {
        self.window = window
    }
    
    
    func start (){
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    var rootViewController: UIViewController {
        let navigationController = UINavigationController(rootViewController: self.Main.viewController(for: .Form))
        self.navController = navigationController
       return navigationController
    }
}
