//
//  NetworkClient.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import Alamofire
import RxSwift
import RxRelay

class NetworkClient {
    func performRequest<T: Decodable>(_ object: T.Type, router: APIRouter) -> Single<ResponseObject<T>> where T : Decodable {
        return Single.create { (observer) -> Disposable in
            
            AF.request(router)
                .responseDecodable(of: ResponseObject<T>.self) { (response) in
                    switch response.result {
                    case .success(let responseObject):
                        PrintHelper.logNetwork("""
                            ✅ Response: \(response.request?.httpMethod?.uppercased() ?? "") '\(String(describing: router.urlRequest))':
                            🧾 Status Code: \(response.response?.statusCode ?? 0), 💾 \(response.data ?? Data()), ⏳ time: \(Date().timeIntervalSince(Date()))
                            ⬇️ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                            ⬇️ Response Body = \(String(data: response.data ?? Data(), encoding: String.Encoding.utf8) ?? "")
                            """ )
                        observer(.success(responseObject))
                    case .failure(let error):
                        print(error.localizedDescription)
                        if let statusCode = response.response?.statusCode {
                            switch ServiceError.init(rawValue: statusCode) {
                            case .badRequest:
                                do {
                                    let failerResponseModel = try JSONDecoder().decode(ServerErrorResponse.self, from: response.data ?? Data())
                                    guard let errors = failerResponseModel.errors, !errors.name.isEmpty else {
                                        observer(.failure(AppError(message: "")))
                                        return
                                    }
                                    observer(.failure(AppError(message: errors.name[0])))
                                } catch let error {
                                    observer(.failure(error))
                                }
                            default:
                                if let reason = ServiceError(rawValue: statusCode) {
                                    observer(.failure(reason))
                                }
                            }
                        }
                        print("No InterNet Connetion Network Client")
                    }
                }.resume()
            return Disposables.create()
        }
    }
   
}

class PrintHelper {
    static func logNetwork<T>(_ items: T, separator: String = " ", terminator: String = "\n") {
        print("""
            \n===================== 📟 ⏳ 📡 =========================
            \(items)
            ======================= 🚀 ⌛️ 📡 =========================
            """, separator: separator, terminator: terminator)
    }
}
extension Dictionary {
    var json: String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? "Not a valid JSON"
        } catch {
            return "Not a valid JSON"
        }
    }
}
