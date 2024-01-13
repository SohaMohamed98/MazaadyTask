//
//  HomeVM.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import Foundation
import RxSwift
import RxRelay
class HomeVM: BaseViewModel{
    let currentPage = BehaviorRelay<Int>(value: 0)
    private var items: [ItemModel] = ItemModel.items
    
    let headersObservable = Observable<[HeaderModel]>.just(HeaderModel.headers)
    let typesObservable = Observable<[TypeModel]>.just(TypeModel.types)
    var itemsSubject: BehaviorRelay<[ItemModel]> = .init(value: ItemModel.items)
    
    func filterItemsByCategoryId(categoryId: Int) {
        if categoryId == 0{ //All option
            itemsSubject.accept( ItemModel.items)
        }else{
            let filteredItems = items.filter { $0.id == categoryId }
            itemsSubject.accept(filteredItems)
        }
    }
}
