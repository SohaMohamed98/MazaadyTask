//
//  DesignableUIView.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import UIKit

@IBDesignable
class DesignableUIView: UIView{
        
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 0.0 {
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float = 0.0 {
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize = CGSize.zero{
        didSet{
            self.layer.shadowOffset = shadowOffset
        }
    }
}
