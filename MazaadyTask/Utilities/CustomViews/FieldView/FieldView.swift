//
//  FieldView.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import UIKit
import RxGesture
import RxSwift
@IBDesignable
class FieldView: NibLoadingView {

    @IBOutlet weak var uiContainerView: DesignableUIView!
    @IBOutlet private weak var uiTitleLabel: UILabel!
    @IBOutlet weak var uiNameLabel: UILabel!
    var disposeBag = DisposeBag()
    var buttonTapped: (()->())?
    
    @IBInspectable
    var title: String = "" {
        didSet{
            uiTitleLabel.text = "  " + title + "  "
        }
    }
    
    @IBInspectable
    var name: String = "" {
        didSet{
            uiNameLabel.text = name
        }
    }
    @IBInspectable
    var showTitle:Bool = false {
        didSet{
            uiTitleLabel.isHidden = !showTitle
        }
    }
    
    func actionTapped(){
        self.uiContainerView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext:{[weak self] _ in
                guard let self = self else{return}
                self.uiTitleLabel.isHidden = false
                self.buttonTapped?()
            }).disposed(by: self.disposeBag)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.actionTapped()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.actionTapped()
      //  fatalError("init(coder:) has not been implemented")
    }
    
    
}
