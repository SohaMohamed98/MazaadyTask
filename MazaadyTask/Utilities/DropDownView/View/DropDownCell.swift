//
//  DropDownCell.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import UIKit

class DropDownCell: UITableViewCell {

    @IBOutlet weak var uiTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isSelected: Bool{
        didSet{
            
            self.contentView.backgroundColor = isSelected ? .blue.withAlphaComponent(0.3) : .clear
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
