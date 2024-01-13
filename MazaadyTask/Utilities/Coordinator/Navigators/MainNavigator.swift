//
//  MainNavigator.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
class MainNavigator: Navigator{
    var coordinator: Coordinator!
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    enum Destination{
        case tabBar
        case Form
        case home
        case DropDown(list: [Category],  selectedType: BehaviorRelay<Category?>)
    }
    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .home:
            let viewModel = HomeVM()
            return HomeVC(viewModel: viewModel, coordinator: coordinator)
        case .Form:
            let viewModel = FormVM(repo: FormRepo())
            return FormVC(viewModel: viewModel, coordinator: coordinator)
        case .DropDown(list: let list, selectedType: let selectedType):
            let viewModel = DropDownVM(list: list, selectedCategory: selectedType)
            let vc = DropDownController(viewModel: viewModel, coordinator: coordinator)
            vc.modalPresentationStyle = .overFullScreen
            return vc
        case .tabBar:
            return CustomTabBarController(coordinator: coordinator)
        }
    }
    
}
