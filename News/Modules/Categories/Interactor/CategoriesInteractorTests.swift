//
//  CategoriesInteractorTests.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class CategoriesInteractorTests: XCTestCase {
    private var categoriesProvider: CategoriesProviderProtocolMock!
    private var output: CategoriesInteractorOutputMock!
    private lazy var interactor: CategoriesInteractor = {
        let interactor = CategoriesInteractor(categoriesProvider: categoriesProvider)
        interactor.output = output
        return interactor
    }()

    override func setUp() {
        super.setUp()

        categoriesProvider = .init()
        output = .init()
    }
    
    func testGetCategories() {
        categoriesProvider.getCategoriesHandler = { completion in
            completion(.success([.business]))
        }
        output.didGetCategoriesHandler = { categories in
            XCTAssertEqual(categories, [.business])
        }

        interactor.getCategories()
        
        XCTAssertEqual(categoriesProvider.getCategoriesCallCount, 1)
        XCTAssertEqual(output.didGetCategoriesCallCount, 1)
    }
    
    func testGetCategoryAt() {
        categoriesProvider.getCategoriesHandler = { completion in
            completion(.success([.business]))
        }
        output.didGetCategoryHandler = { category in
            XCTAssertEqual(category, .business)
        }
        
        interactor.getCategories()
        interactor.getCategoryAt(index: 0)
        
        XCTAssertEqual(categoriesProvider.getCategoriesCallCount, 1)
        XCTAssertEqual(output.didGetCategoriesCallCount, 1)
        XCTAssertEqual(output.didGetCategoryCallCount, 1)
    }
}
