//
//  CustomPageControl.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import Foundation
import UIKit

class CustomPageControl: UIPageControl {
    
    override func draw(_ rect: CGRect) {
        let indicatorSize: CGSize = CGSize(width: 18, height: 8)
        let spacing: CGFloat = 5.0
        
        let totalWidth = CGFloat(numberOfPages) * indicatorSize.width + CGFloat(max(0, numberOfPages - 1)) * spacing
        var currentX = (rect.width - totalWidth) / 2.0
        
        let currentColor = currentPageIndicatorTintColor ?? UIColor.white
        let defaultColor = pageIndicatorTintColor ?? UIColor.lightGray
        
        for i in 0..<numberOfPages {
            let indicatorRect = CGRect(x: currentX, y: rect.height / 2 - indicatorSize.height / 2, width: indicatorSize.width, height: indicatorSize.height)
            let indicatorPath = UIBezierPath(roundedRect: indicatorRect, cornerRadius: indicatorSize.height / 2)
            
            if i == currentPage {
                currentColor.setFill()
                
            } else {
                defaultColor.setFill()
            }
            
            indicatorPath.fill()
            
            
            currentX += indicatorSize.width + spacing
        }
    }
}
