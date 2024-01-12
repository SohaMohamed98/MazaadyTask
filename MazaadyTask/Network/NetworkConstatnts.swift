//
//  NetworkConstatnts.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import Foundation
enum BaseURLS: String{
    case Test = "https://staging.mazaady.com/"
}

class NetworkConstatnts{
    static let baseURL: String = BaseURLS.Test.rawValue // Test or Live
    static let apiURL:String = NetworkConstatnts.baseURL + "api"
    static let primaryKey: String = "3%o8i}_;3D4bF]G5@22r2)Et1&mLJ4?$@+16"
}
