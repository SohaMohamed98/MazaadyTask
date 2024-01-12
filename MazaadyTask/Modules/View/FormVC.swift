//
//  FormVC.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
class FormVC: UIViewController {

    let disposeBag = DisposeBag()
    let repo = FormRepo()
    @IBOutlet weak var uiCategoryView: FieldView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.uiCategoryView.buttonTapped = {
            print("category")
        }
        
        repo.getAllCategories().subscribe(onSuccess: { [weak self] response in
            guard let self = self else { return }
           print(response)
        }, onFailure: { [weak self] error in
            guard let self = self else { return }
           
        }).disposed(by: disposeBag)
       
       
    }
}
