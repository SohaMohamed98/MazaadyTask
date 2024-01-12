//
//  FormRepo.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
import RxSwift

protocol FormRepoProtocol {
    func getAllCategories() -> Single<(FormModel)>
   
}

class FormRepo: BaseRepository, FormRepoProtocol {
    func getAllCategories() -> Single<(FormModel)> {
        return Single.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create() }
            
            self.networkClient.performRequest(FormModel.self, router: FormRouter.getAllCategories)
                .subscribe { baseResponse in
                    guard let code = baseResponse.code else { return }
                    if (code != 200) {
                        observer(.failure(AppError(message: baseResponse.message ?? "")))
                    } else if let data = baseResponse.data {
                        observer(.success(data))
                    } else {
                        observer(.failure(AppError(message: "No data found in response")))
                    }
                } onFailure: { (error) in
                    observer(.failure(error))
                }
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}

