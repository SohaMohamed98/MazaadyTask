//
//  FormVC.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import UIKit

class FormVC: UIViewController {

    @IBOutlet weak var uiCategoryView: FieldView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.uiCategoryView.buttonTapped = {
            print("category")
        }
        self.uiCategoryView.name = "Category"
       
    }
}
