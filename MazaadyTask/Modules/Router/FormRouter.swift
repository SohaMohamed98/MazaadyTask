//
//  FormRouter.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import Alamofire

enum FormRouter: APIRouter {
    case getAllCategories
    var method: HTTPMethod{
        switch self {
       default:
            return .get
        }
    }
    
    var path: String{
        switch self {
        case .getAllCategories:
            return "v1/get_all_cats"
        }
    }
    
    var parameters: Parameters?{
        switch self {
        default:
            return nil
        }
    }
    
    var encoding: Alamofire.ParameterEncoding{
        switch self {
        default:
            return URLEncoding.default
        }
    }
}
