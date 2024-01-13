//
//  HomeViewModel.swift
//  MazaadyTaskTests
//
//  Created by mac on 13/01/2024.
//

import XCTest
@testable import MazaadyTask
import RxSwift
import RxCocoa

 class HomeViewModel: XCTestCase {

     var homeViewModel: HomeVM!
     var disposeBag: DisposeBag!
     override func setUp() {
         homeViewModel = HomeVM()
         disposeBag = DisposeBag()
         super.setUp()
     }
     
     override func tearDown() {
         homeViewModel = nil
         disposeBag = nil
         super.tearDown()
        
     }
     
     func testNilItems(){
         let expectation = XCTestExpectation(description: "Get items Count")
         var responseItems: [ItemModel]?
         
         self.homeViewModel.itemsSubject.subscribe(onNext:{[weak self] types in
             guard let self = self else{return}
             responseItems = types
             expectation.fulfill()
         }).disposed(by: self.disposeBag)
         wait(for: [expectation], timeout: 1)
         
         XCTAssertNotNil(responseItems)
         XCTAssertGreaterThan(responseItems?.count ?? 0, 1)
     }
     
     func testCountTypes(){
         let expectation = XCTestExpectation(description: "Get Types Count")
         var responseTypes: [TypeModel]?
         
         self.homeViewModel.typesObservable.subscribe(onNext:{[weak self] types in
             guard let self = self else{return}
             responseTypes = types
             expectation.fulfill()
         }).disposed(by: self.disposeBag)
         wait(for: [expectation], timeout: 1)
         
         XCTAssertNotNil(responseTypes)
         XCTAssertGreaterThan(responseTypes?.count ?? 0, 1)
     }
     
     func testFilterTypes(){
        let expectation = XCTestExpectation(description: "Get Types Count")
         var responseItems: [ItemModel]?
         self.homeViewModel.filterItemsByCategoryId(categoryId: 2)
         responseItems = self.homeViewModel.itemsSubject.value
          expectation.fulfill()
          wait(for: [expectation], timeout: 1)
         
         XCTAssertNotNil(responseItems)
         XCTAssertEqual(responseItems?.count ?? 0, 1)
     }
     

}
