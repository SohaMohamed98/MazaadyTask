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
    case getProperties(subCategoruId: Int)
    case getModels(optionId: Int)
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
        case .getProperties:
            return "v1/properties"
        case .getModels(optionId: let optionId):
            return "v1/get-options-child/\(optionId)"
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case let .getProperties(subCategoruId: catId):
            return ["cat": catId]
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
