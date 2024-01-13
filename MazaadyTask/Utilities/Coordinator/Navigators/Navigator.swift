//
//  Navigator.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import Foundation
import UIKit

enum NavigatorTypes{
    case push
    case present
    case root
    case popToDestination
}
protocol Navigator{
    associatedtype Destination
    func viewController(for destination: Destination) -> UIViewController
    var coordinator:Coordinator! {get}
    init(coordinator: Coordinator)
    func navigate(to destination: Destination, navigatorType: NavigatorTypes, animated: Bool)
}

extension Navigator{
    func navigate(to destination: Destination, navigatorType: NavigatorTypes = .push, animated: Bool = true){
        let viewController = viewController(for: destination)
        switch navigatorType {
        case .push:
            coordinator.selectedNavigationController?.pushViewController(viewController, animated: animated)
        case .present:
            coordinator.selectedNavigationController?.present(viewController, animated: animated)
        case .root:
            coordinator.selectedNavigationController?.setViewControllers([viewController], animated: animated)
        case .popToDestination:
            let vc = coordinator.selectedNavigationController?.viewControllers.filter({$0.nibName ?? "" == viewController.nibName ?? ""}).first
            if (vc != nil) {
                coordinator.selectedNavigationController?.popToViewController(vc!, animated: true)
            }
        }
        
    }
}
