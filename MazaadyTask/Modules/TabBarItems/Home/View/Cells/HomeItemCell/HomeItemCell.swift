//
//  HomeItemCell.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import UIKit

class HomeItemCell: UICollectionViewCell {
    @IBOutlet weak var uiFreeFlagContainer: DesignableUIView!
    @IBOutlet weak var uiBannerImg: UIImageView!
    @IBOutlet weak var uiPersonImageLabel: UIImageView!
    @IBOutlet weak var uiTitle: UILabel!
    @IBOutlet weak var uiTimeLabel: UILabel!
    @IBOutlet weak var uiFreeFlagLabel: UILabel!
    @IBOutlet weak var uiLessonLabel: UILabel!
    @IBOutlet weak var uiCategoryLabel: UILabel!
    @IBOutlet weak var uiFreeLabel: UILabel!
    
    @IBOutlet weak var uiPositionLabel: UILabel!
    @IBOutlet weak var uiAuthorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(item: ItemModel){
        self.uiTitle.text = item.title
        self.uiBannerImg.image = UIImage(named: item.bookImage)
        if let freeFlag =  item.freeFlag, !freeFlag.isEmpty {
            self.uiFreeFlagLabel.text = item.freeFlag
            self.uiFreeLabel.text = "  " + (item.free ?? "") + "  "
            self.uiFreeFlagContainer.isHidden = false
            self.uiFreeLabel.isHidden = false
        }else{
            self.uiFreeFlagContainer.isHidden = true
            self.uiFreeLabel.isHidden = true
        }
        self.uiTimeLabel.text = item.time
        self.uiAuthorLabel.text = item.author
        self.uiPersonImageLabel.image = UIImage(named: item.authorImage)
        self.uiLessonLabel.text = "  " + item.lessonNumber + "  "
        self.uiCategoryLabel.text = "  " + item.category + "  "
        self.uiPositionLabel.text = item.position
    }

}
