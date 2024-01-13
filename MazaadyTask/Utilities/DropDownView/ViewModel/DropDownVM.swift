//
//  DropDownVM.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class DropDownVM: BaseViewModel {
    
    var listSubject: BehaviorRelay<[Category]>?
    var selectedCategory: BehaviorRelay<Category?>
    var myList: [Category]
    init(list: [Category], selectedCategory: BehaviorRelay<Category?>) {
        self.myList = list
        self.selectedCategory = selectedCategory
        super.init()
    }
}
