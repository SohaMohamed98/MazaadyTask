//
//  FormVM.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import RxSwift
import RxRelay

class FormVM: BaseViewModel {
    
    //MARK: - Network -
    var repo: FormRepo
    
    //MARK: - Category -
    var categoriesSubject: BehaviorRelay<[Category]> = .init(value: [])
    var selectedCategoryId: BehaviorRelay<Int> = .init(value: 0)
    var selectedCategory: BehaviorRelay<Category?> = .init(value: nil)
    var allCategories: [Category] = []
    
    //MARK: SubCategory -
    var selectedChild: BehaviorRelay<Category?> = .init(value: nil)
    var childrenSubject: PublishSubject<[Category]> = .init()
    var subCategries: [Category] = []
    
    //MARK: - Process Type -
    var showSpecifyHere: PublishSubject<Bool> = .init()
    var getPropertiesSuccessfully: PublishSubject<Void> = .init()
    var selectedProperty: BehaviorRelay<Category?> = .init(value: nil)
    var properties: [Category] = []
    
    //MARK: - Brand -
    var showBrand: PublishSubject<Bool> = .init()
    var selectedBrand: BehaviorRelay<Category?> = .init(value: nil)
    var brands: [Category] = []
    
    //MARK: - Model -
    var getModelsSuccessfully: PublishSubject<Void> = .init()
    var selectedModel: BehaviorRelay<Category?> = .init(value: nil)
    var models: [Category] = []
    
    //MARK: - Type -
    var selectedType: BehaviorRelay<Category?> = .init(value: nil)
    var types: [Category] = []
    
    
    init(repo: FormRepo) {
        self.repo = repo
        super.init()
        self.getCategories()
        self.getSubCategory()
        self.selecedCat()
        self.selecedProperties()
        self.selecedModel()
        self.selecedType()
    }

}
extension FormVM {
    
    //MARK: - Category -
    func getCategories(){
        self.isLoading.onNext(true)
       repo.getAllCategories().subscribe(onSuccess: { [weak self] response in
           guard let self = self else { return }
           self.isLoading.onNext(false)
           guard let categories = response.categories, !categories.isEmpty else {return}
           self.allCategories = categories
           categoriesSubject.accept(categories)
           self.selectedCategory.accept(categories.first!)
       }, onFailure: { [weak self] error in
           guard let self = self else { return }
           self.isLoading.onNext(false)
           self.showMessageObservable.onNext((nil,error.localizedDescription))
       }).disposed(by: disposeBag)
   }
    
    //MARK: SubCategory -
    private func getSubCategory(){
        self.selectedCategoryId.subscribe(onNext:{[weak self] categoryId in
            guard let self = self else{return}
            self.getChildForSelectedCategory(id: categoryId)
        }).disposed(by: self.disposeBag)
    }
    private func getChildForSelectedCategory(id: Int){
        let selectedCatego = self.categoriesSubject.value.filter({$0.id == id}).first
        self.childrenSubject.onNext(selectedCatego?.children ?? [])
        self.subCategries = selectedCatego?.children ?? []
        self.selectedBrand.accept(nil)
        self.selectedModel.accept(nil)
        self.selectedType.accept(nil)
    }
    
    //MARK: - Process Type -
    func getProperties(){
        guard let selectedChild = self.selectedChild.value?.id else{
            self.showMessageObservable.onNext((nil, ConstanstMessage.inValidSubCategory.rawValue))
            return
        }
        self.isLoading.onNext(true)
        repo.getProperties(subCategoryId: selectedChild).subscribe(onSuccess: { [weak self] response in
           guard let self = self else { return }
            self.isLoading.onNext(false)
            self.properties = response
            self.properties.append(.init(id: 1000, name: ConstanstMessage.Other.rawValue, children: nil, options: nil))
            self.getPropertiesSuccessfully.onNext(())
       }, onFailure: { [weak self] error in
           guard let self = self else { return }
           self.isLoading.onNext(false)
           self.showMessageObservable.onNext((nil,error.localizedDescription))
       }).disposed(by: disposeBag)
   }
    
    //MARK: - Brand -
    private func getOptionsForSelectedProperty(id: Int){
        let selectedCatego = self.properties.filter({$0.id == id}).first
        self.brands = selectedCatego?.options ?? []
    }
    
    //MARK: - Model -
    func getModels(){
        guard let selectedBrand = self.selectedBrand.value?.id else{
            self.showMessageObservable.onNext((nil, ConstanstMessage.inValidBrand.rawValue))
            return
        }
        self.isLoading.onNext(true)
        repo.getModels(optionId: selectedBrand).subscribe(onSuccess: { [weak self] response in
           guard let self = self else {return }
            self.isLoading.onNext(false)
            guard !response.isEmpty else {
                self.showMessageObservable.onNext((nil, ConstanstMessage.emptyBrand.rawValue))
                return}
            self.models = response
            self.getModelsSuccessfully.onNext(())
       }, onFailure: { [weak self] error in
           guard let self = self else { return }
           self.isLoading.onNext(false)
           self.showMessageObservable.onNext((nil,error.localizedDescription))
       }).disposed(by: disposeBag)
   }
    
    //MARK: - Type -
    private func getTypesFromModelSelected(id: Int){
        let selectedCatego = self.models.filter({$0.id == id}).first
       
    }
    
    
    //MARK: - Bind All Selected items -
    private func selecedCat(){
        self.selectedCategory.subscribe(onNext:{[weak self] cat in
            guard let self = self else{return}
            guard let cat = cat else {return}
            self.getChildForSelectedCategory(id: cat.id ?? 0)
            self.selectedChild.accept(nil)
            self.selectedProperty.accept(nil)
            self.selectedBrand.accept(nil)
            self.selectedModel.accept(nil)
            self.selectedType.accept(nil)
        }).disposed(by: self.disposeBag)
    }
    private func selecedProperties(){
        self.selectedProperty.subscribe(onNext:{[weak self] cat in
            guard let self = self else{
                self?.showBrand.onNext(false)
                return}
            guard let cat = cat else {return}
            self.showBrand.onNext(true)
            self.selectedBrand.accept(nil)
            self.selectedModel.accept(nil)
            self.selectedType.accept(nil)
            guard cat.id != nil else{return}
            if cat.id == 1000 {
                self.showBrand.onNext(false)
                self.showSpecifyHere.onNext(true)
            }else{
                self.showSpecifyHere.onNext(false)
                self.getOptionsForSelectedProperty(id: cat.id ?? 0)
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func selecedModel(){
        self.selectedModel.subscribe(onNext:{[weak self] cat in
            guard let self = self else{return}
            guard let cat = cat else {return}
            self.selectedType.accept(nil)
        }).disposed(by: self.disposeBag)
    }
    
    
    private func selecedType(){
        self.selectedType.subscribe(onNext:{[weak self] cat in
            guard let self = self else{return}
            guard let cat = cat else {return}
        }).disposed(by: self.disposeBag)
    }
    
}
