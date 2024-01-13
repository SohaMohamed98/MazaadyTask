//
//  ColorSystem.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import Foundation
import UIKit

extension DesignSystem {
    enum Colors: String {
        
        case PrimaryRed
        case SecondaryYellowEgg
        case SecondaryYellowOmlette
        case NeutralWhite
        case NeutralGray1
        case NeutralGray2
        case NeutralGray3
        case NeutralGray5
        case NeutralGray6
        case NeutralGray4
        
        
        var color: UIColor{
            return UIColor(named: self.rawValue) ?? .black
        }
    }
}
