//
//  NetworkClient.swift
//  MazaadyTaskTests
//
//  Created by mac on 13/01/2024.
//

import XCTest
import RxSwift
import RxCocoa

@testable import MazaadyTask

 class NetworkClient: XCTestCase {

    var repo: FormRepo!
     var disposeBag: DisposeBag!
    override func setUp() {
        repo = FormRepo()
        disposeBag = DisposeBag()
        super.setUp()
    }
    
    override func tearDown() {
        repo = nil
        disposeBag = nil
        super.tearDown()
    }
    
    
    func testCountCategories(){
        let promise = XCTestExpectation(description: "Fetch Categries completed") // For Asynchronus
        var responseError: Error?
        var responseCategory: FormModel?
        
        repo.getAllCategories().subscribe(onSuccess: { [weak self] response in
           guard let self = self else { return }
           responseCategory = response
            promise.fulfill()
       }, onFailure: { [weak self] error in
           guard let self = self else { return }
            responseError = error
           promise.fulfill()
       }).disposed(by: self.disposeBag)
        wait(for: [promise], timeout: 5)
        // Then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseCategory)
        //ForCount
        XCTAssertEqual(responseCategory?.categories?.count, 14)
   }
     
     func testNumberOfChild(){
         let promise = XCTestExpectation(description: "Fetch Subcategories completed") // For Asynchronus
         var responseError: Error?
         var responseTypes: CatModel?
         
         repo.getProperties(subCategoryId: 3).subscribe(onSuccess: { response in
             responseTypes = response
             promise.fulfill()
        }, onFailure: { error in
             responseError = error
            promise.fulfill()
        }).disposed(by: self.disposeBag)
         wait(for: [promise], timeout: 8)
         // Then
         XCTAssertNil(responseError)
         XCTAssertNotNil(responseTypes)
    }
     
     
     func testNullableModels(){
         let promise = XCTestExpectation(description: "Fetch models completed") // For Asynchronus
         var responseError: Error?
         var responseModel: CatModel?
         
         repo.getModels(optionId: 53).subscribe(onSuccess: { response in
             responseModel = response
             promise.fulfill()
        }, onFailure: { error in
             responseError = error
            promise.fulfill()
        }).disposed(by: self.disposeBag)
         wait(for: [promise], timeout: 5)
         // Then
         XCTAssertNil(responseError)
         XCTAssertNotNil(responseModel)
         XCTAssertTrue(responseError == nil)
    }

}
