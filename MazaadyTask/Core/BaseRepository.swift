//
//  BaseRepository.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import RxSwift

class BaseRepository{
    var disposeBag: DisposeBag = .init()
    let networkClient:NetworkClient!
    
    init(networkClient:NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    final func callApiRequest<T>(reponseType: T.Type, rotuer: APIRouter)->Single<T> where T: Decodable {
        return Single.create {[weak self] observer -> Disposable in
            guard let self = self else {return Disposables.create()}
            self.networkClient.performRequest(T.self,
                                              router: rotuer)
                .subscribe { (baseResponse) in
                    let code = baseResponse.code ?? 400
                 if code != 200 {
                     observer(.failure(AppError(message: baseResponse.message ?? "")))
                    } else {
                        if isArray(type: reponseType.self) {
                            guard let data = baseResponse.data ?? [] as? T else {
                                observer(.failure(AppError.init(message: baseResponse.message ?? "")))
                                return
                            }
                            observer(.success(data))
                        } else {
                            guard let singleObjectModel = baseResponse.data else{
                                observer(.failure(AppError(message: baseResponse.message ?? "")))
                                return
                            }
                            observer(.success(singleObjectModel))
                        }
                    }
                } onFailure: { (error) in
                    observer(.failure(error))
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    
}
protocol AnyTypeOfArray {}
extension Array: AnyTypeOfArray {}
func isArray<T>(type: T.Type) -> Bool {
    return T.self is AnyTypeOfArray.Type
}
