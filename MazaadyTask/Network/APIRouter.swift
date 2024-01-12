//
//  APIRouter.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible{
    var method: HTTPMethod { get }
    var path: String  { get }
    var parameters: Parameters?  { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? {get}
}

extension APIRouter {
    var headers: HTTPHeaders? {
            let headers: HTTPHeaders = [
                "private-key": "\(NetworkConstatnts.primaryKey)"
            ]
            return headers
    }
  
    func asURLRequest() throws -> URLRequest {
        guard var url: URL = URL(string: NetworkConstatnts.apiURL) else {
            throw ApiError.URLNotValid
        }
        url.appendPathComponent(path)
        var request = try URLRequest(url: url, method: method, headers: headers)
        return try encoding.encode(request, with: parameters)
    }
   
   
}
enum ApiError: Error {
    case URLNotValid
}
