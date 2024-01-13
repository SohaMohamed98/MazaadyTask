//
//  FormVC.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class FormVC: BaseWireFrame<FormVM> {
    
    @IBOutlet weak var uiHomeBtn: UIButton!
    @IBOutlet weak var uiTypeView: FieldView!
    @IBOutlet weak var uiModelView: FieldView!
    @IBOutlet weak var uiBrandView: FieldView!
    @IBOutlet weak var specifyTF: UITextField!
    @IBOutlet weak var uiSpecifyHereTitle: UILabel!
    @IBOutlet weak var uiSpecifyHereView: DesignableUIView!
    @IBOutlet weak var uiProcessView: FieldView!
    @IBOutlet weak var uiSubCategoryView: FieldView!
    @IBOutlet weak var uiCategoryView: FieldView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getCategories()
    }
    
    override func bind(viewModel: FormVM) {
        bindAllFields()
        categoryTapped()
        childTapped()
        processTapped()
        designSpecifyTF()
        bindProperties()
        showOrHideSpecifyField()
        brandTapped()
        showOrHideBrand()
        modelsTapped()
        bindModels()
        typeTapped()
        homeTapped()
        
    }
    
    private func bindAllFields(){
        self.viewModel.selectedCategory.map({$0?.name ?? ConstanstMessage.categoryPlaceholder.rawValue})
            .bind(to: self.uiCategoryView.uiNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        self.viewModel.selectedChild.map({$0?.name ?? ConstanstMessage.subCategoryPlaceholder.rawValue})
            .bind(to: self.uiSubCategoryView.uiNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        self.viewModel.selectedProperty.map({$0?.name ?? ConstanstMessage.PropertiesPlaceholder.rawValue})
            .bind(to: self.uiProcessView.uiNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        self.viewModel.selectedBrand.map({$0?.name ?? ConstanstMessage.brandPlaceholder.rawValue})
            .bind(to: self.uiBrandView.uiNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        self.viewModel.selectedModel.map({$0?.name ?? ConstanstMessage.modelPlaceholder.rawValue})
            .bind(to: self.uiModelView.uiNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        self.viewModel.selectedType.map({$0?.name ?? ConstanstMessage.TypePlaceholder.rawValue})
            .bind(to: self.uiTypeView.uiNameLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
}

extension FormVC {
    
    // MARK: - Categories -
    private func categoryTapped(){
        self.uiCategoryView.buttonTapped = {
            guard !self.viewModel.allCategories.isEmpty else {
                self.viewModel.getCategories()
                return
            }
            self.presentDropDown(list: self.viewModel.allCategories, selectedType:self.viewModel.selectedCategory)
        }
    }
    
    // MARK: - SubCategories -
    private func childTapped(){
        self.uiSubCategoryView.buttonTapped = {
            guard !self.viewModel.subCategries.isEmpty else {
                return
            }
            self.viewModel.selectedProperty.accept(nil)
            self.viewModel.selectedBrand.accept(nil)
            self.viewModel.selectedModel.accept(nil)
            self.viewModel.selectedType.accept(nil)
            self.presentDropDown(list: self.viewModel.subCategries, selectedType:self.viewModel.selectedChild)

        }
    }
    
    // MARK: - Properties -
    private func processTapped(){
        self.uiProcessView.buttonTapped = {
            self.viewModel.getProperties()
        }
    }
    private func bindProperties(){
        self.viewModel.getPropertiesSuccessfully.subscribe(onNext:{[weak self] _ in
            guard let self = self else{return}
            self.presentDropDown(list: self.viewModel.properties, selectedType:self.viewModel.selectedProperty)
        }).disposed(by: self.disposeBag)
    }
    private func designSpecifyTF(){
        self.specifyTF.rx.controlEvent([.editingDidBegin, .editingChanged])
            .subscribe(onNext:{[weak self] value in
            guard let self = self else{return}
            if !((specifyTF.text ?? "").isEmpty) {
                self.uiSpecifyHereTitle.isHidden = false
            }else{
                self.uiSpecifyHereTitle.isHidden = true
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func showOrHideSpecifyField(){
        self.viewModel.showSpecifyHere.subscribe(onNext:{[weak self] value in
            self?.uiSpecifyHereView.isHidden = !value
        }).disposed(by: self.disposeBag)
    }
    
    
    // MARK: - Brand -
    private func brandTapped(){
        self.uiBrandView.buttonTapped = {
            guard !self.viewModel.brands.isEmpty else {
                self.viewModel.showMessageObservable.onNext((nil, ConstanstMessage.emptyBrand.rawValue))
                return
            }
            self.presentDropDown(list: self.viewModel.brands, selectedType:self.viewModel.selectedBrand)
        }
    }
    
    private func showOrHideBrand(){
        self.viewModel.showBrand.subscribe(onNext:{[weak self] value in
            guard let self = self else{return}
            self.uiBrandView.isHidden = !value
            self.uiModelView.isHidden = !value
            self.uiTypeView.isHidden = !value
            if !value {
                self.viewModel.selectedBrand.accept(nil)
                self.viewModel.selectedModel.accept(nil)
                self.viewModel.selectedType.accept(nil)
            }
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: - Model -
    private func modelsTapped(){
        self.uiModelView.buttonTapped = {
            self.viewModel.getModels()
        }
    }

    
    private func bindModels(){
        self.viewModel.getModelsSuccessfully.subscribe(onNext:{[weak self] _ in
            guard let self = self else{return}
            self.presentDropDown(list: self.viewModel.models, selectedType:self.viewModel.selectedModel)
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: - Type -
    private func typeTapped(){
        self.uiTypeView.buttonTapped = {
            guard !self.viewModel.models.isEmpty else {
                self.viewModel.showMessageObservable.onNext((nil, ConstanstMessage.inValidModel.rawValue))
                return
            }
            guard !self.viewModel.types.isEmpty else {
                self.viewModel.showMessageObservable.onNext((nil, ConstanstMessage.emptyType.rawValue))
                return}
            self.presentDropDown(list: self.viewModel.types, selectedType: self.viewModel.selectedType)
           
        }
    }
    
    
    private func presentDropDown(list: [Category],  selectedType: BehaviorRelay<Category?>){
        DispatchQueue.main.async {
            let vc = DropDownController(viewModel:
                    .init(list: list,
                          selectedCategory: selectedType))
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    private func homeTapped(){
        self.uiHomeBtn.rx.tap.subscribe(onNext:{[weak self] _ in
            guard let self = self else{return}
            //TODO: - Navigate To Tabbar
        }).disposed(by: self.disposeBag)
    }
    
    
}


