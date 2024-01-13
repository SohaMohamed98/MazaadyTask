//
//  BaseWireFrame.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BaseWireFrame<T: BaseViewModel>: UIViewController , UIGestureRecognizerDelegate{
    var viewModel: T!
    var coordinator : Coordinator!
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    private lazy var indicator:UIActivityIndicatorView = {
        var activityView = UIActivityIndicatorView(style: .large)
        return activityView
    }()
    
    private lazy var bgColorView = UIView()
    init(viewModel: T, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
        
        self.baseBind()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    func bind(viewModel: T){
        fatalError("Please override bind function")
    }
    func baseBind(){
        viewModel.showMessageObservableWithAction.subscribe{[weak self] (title, message, observable) in
            guard let self = self else {return}
            self.showMessage(title: title, message: message, observable: observable)
        }.disposed(by: self.disposeBag)
        viewModel.showMessageObservable.subscribe {[weak self] (title, message) in
            guard let self = self else {return}
            self.showMessage(title: title, message: message, observable: nil)
        }.disposed(by: self.disposeBag)
        
        viewModel.isLoading.observe(on: MainScheduler.instance).subscribe(onNext:{[weak self] isShow in
            guard let self = self else{return}
            isShow ? self.showActivityIndicatory() : self.removeActivity()
        }).disposed(by: self.disposeBag)
        
    }
    
    func showMessage(title: String?, message: String, observable: PublishSubject<Void>?){
        let messageAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        messageAlert.title = title
        messageAlert.message = message
        messageAlert.addAction(UIAlertAction(title: "Ok", style: .cancel){ _ in
            observable?.onNext(())
        })
        self.present(messageAlert, animated: true, completion: nil)
    }
    
    func showActivityIndicatory() {
        indicator.center = self.view.center
        bgColorView.backgroundColor = UIColor(white: 0, alpha: 0)
        self.view.addSubview(bgColorView)
        bgColorView.translatesAutoresizingMaskIntoConstraints = false
        bgColorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bgColorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bgColorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        bgColorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    func removeActivity(){
        indicator.stopAnimating()
        bgColorView.removeFromSuperview()
        indicator.removeFromSuperview()
    }
}

