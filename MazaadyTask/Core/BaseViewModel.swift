//
//  BaseViewModel.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: NSObject{
    var disposeBag = DisposeBag()
    var isLoading: BehaviorSubject<Bool> = .init(value: false)
    lazy var showMessageObservable: PublishSubject<(String?, String)> = .init()
    lazy var showMessageObservableWithAction: PublishSubject<(String?, String, PublishSubject<Void>)> = .init()
    var refreshTable: PublishSubject<Void> = .init()    
}
