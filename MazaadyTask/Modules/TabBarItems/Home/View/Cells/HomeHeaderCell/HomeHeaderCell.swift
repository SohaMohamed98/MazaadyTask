//
//  HomeHeaderCell.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import UIKit

class HomeHeaderCell: UICollectionViewCell {

    @IBOutlet weak var uiPersonImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(headerModel: HeaderModel){
        self.uiPersonImage.image = UIImage(named: headerModel.image)
    }
}
