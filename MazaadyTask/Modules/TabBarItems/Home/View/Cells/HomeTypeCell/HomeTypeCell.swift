//
//  HomeTypeCell.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import UIKit

class HomeTypeCell: UICollectionViewCell {

    @IBOutlet weak var uiContainerView: UIView!
    @IBOutlet weak var uiTypeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isSelected: Bool{
        didSet {
            if isSelected{
                self.uiContainerView.backgroundColor = DesignSystem.Colors.PrimaryRed.color
                self.uiTypeLabel.textColor = DesignSystem.Colors.NeutralWhite.color
            }else{
                self.uiContainerView.backgroundColor = DesignSystem.Colors.NeutralGray6.color
                self.uiTypeLabel.textColor = DesignSystem.Colors.NeutralGray3.color
            }
        }
    }
    func configureCell(typeModel: TypeModel){
        self.uiTypeLabel.text = typeModel.typeTitle
    }
}
