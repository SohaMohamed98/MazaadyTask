//
//  HomeVC.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import UIKit
import RxSwift
class HomeVC: BaseWireFrame<HomeVM> {
    
    @IBOutlet weak var uiTypeCollection: UICollectionView!{
        didSet{
            uiTypeCollection.register(
                .init(nibName: HomeTypeCell.identifier, bundle: nil),
                forCellWithReuseIdentifier: HomeTypeCell.identifier)
        }
    }
    @IBOutlet weak var uiHeaderCollection: UICollectionView!{
        didSet{
            uiHeaderCollection.register(
                .init(nibName: HomeHeaderCell.identifier,
                      bundle: nil), forCellWithReuseIdentifier: HomeHeaderCell.identifier)
        }
    }
    @IBOutlet weak var uiItemCollection: UICollectionView!{
        didSet{
            uiItemCollection.register(
                .init(nibName: HomeItemCell.identifier, bundle: nil),
                forCellWithReuseIdentifier: HomeItemCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bind(viewModel: HomeVM) {
        bindHeaders()
        bindTypes()
        bindItems()
        bindTypeSelected()
        willDisplayTypeCollection()
        typeSelected()
        designType()
        designItem()
    }
    
    
    // MARK: - Configure Header Collection -
    func bindHeaders(){
        self.uiHeaderCollection.rx.setDelegate(self).disposed(by: self.disposeBag)
        viewModel.headersObservable.bind(to:self.uiHeaderCollection.rx
            .items(cellIdentifier: HomeHeaderCell.identifier,
                   cellType: HomeHeaderCell.self)){row, item, cell in
            cell.configureCell(headerModel: item)
        }.disposed(by: self.disposeBag)
    }
    
    
    // MARK: - Configure Type Collection -
    func designType(){
        let layout = uiTypeCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
    }
    func bindTypes(){
        viewModel.typesObservable.bind(to: self.uiTypeCollection.rx
            .items(cellIdentifier: HomeTypeCell.identifier,
                   cellType: HomeTypeCell.self)){row, item, cell in
            cell.configureCell(typeModel: item)
        }.disposed(by: self.disposeBag)
    }
    private func willDisplayTypeCollection(){
        uiTypeCollection.rx.willDisplayCell
            .take(1)
            .subscribe(onNext: { cell, indexPath in
                if indexPath.row == 0 {
                    cell.isSelected = true
                } else {
                    cell.isSelected = false
                }
            })
            .disposed(by: disposeBag)
    }
    private func typeSelected(){
        uiTypeCollection.rx
            .itemSelected
            .take(1)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                if let cell = self.uiTypeCollection.cellForItem(at:
                        .init(item: 0, section: 0)) as? HomeTypeCell{
                    cell.isSelected = false
                }
            })
            .disposed(by: disposeBag)
    }
    private func bindTypeSelected() {
        uiTypeCollection.rx
            .modelSelected(TypeModel.self)
            .map { ( $0.id ) }
            .subscribe(onNext: { [weak self] selectedModel in
                guard let self = self else { return }
                self.viewModel.filterItemsByCategoryId(categoryId: selectedModel)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure Item Collection -
    func designItem(){
        let itemlayout = uiItemCollection.collectionViewLayout as! UICollectionViewFlowLayout
        itemlayout.itemSize = .init(width: uiItemCollection.frame.width-30, height: uiItemCollection.frame.width-10)
    }
    func bindItems(){
        viewModel.itemsSubject.bind(to: self.uiItemCollection.rx
            .items(cellIdentifier: HomeItemCell.identifier,
                   cellType: HomeItemCell.self)){row, item, cell in
            cell.configureCell(item: item)
        }.disposed(by: self.disposeBag)
    }
    
    
}

extension HomeVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            let width = collectionView.frame.width-40
            return .init(width: width/4, height: width/4)
        default:
            let layout = uiTypeCollection.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = UICollectionViewFlowLayout.automaticSize
            return layout.itemSize
        }
    }
    
}
