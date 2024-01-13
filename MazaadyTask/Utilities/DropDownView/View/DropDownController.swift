//
//  DropDownController.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
class DropDownController: BaseWireFrame<DropDownVM> {

    @IBOutlet weak var uiTableView: UITableView!{
        didSet{
            uiTableView.register(.init(nibName: "DropDownCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(touched))
//        self.view.addGestureRecognizer(tap)
        uiTableView.rowHeight = 40
        self.uiTableView.delegate = self
        self.uiTableView.dataSource = self
        
    }
    
    override func bind(viewModel: DropDownVM) {
       // self.uiTableView.rx.setDelegate(self).disposed(by: self.disposeBag)
//        viewModel.listSubject?.bind(to: self.uiTableView.rx.items(cellIdentifier: "DropDownCell", cellType: DropDownCell.self)){row, item, cell in
//            cell.uiTitleLabel.text = item.name ?? ""
//
//        }.disposed(by: self.disposeBag)
        
        
//        self.uiTableView.rx.modelSelected(Category.self).subscribe(onNext:{[weak self] category in
//            guard let self = self else{return}
//            self.viewModel.selectedCategory.accept(category)
//            self.dismiss(animated: true)
//        }).disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.1) {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            }
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.backgroundColor = .clear
    }
    @objc func touched() {
        //self.dismiss(animated: true)
    }
    
   
}

extension DropDownController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath) as! DropDownCell
        cell.uiTitleLabel.text = viewModel.myList[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.myList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true){
            self.viewModel.selectedCategory.accept(self.viewModel.myList[indexPath.row])
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let selectedCategory = self.viewModel.selectedCategory.value else {return}
        if self.viewModel.myList[indexPath.row].id == selectedCategory.id {
            cell.isSelected = true
        }
    }
    
    
    
}
