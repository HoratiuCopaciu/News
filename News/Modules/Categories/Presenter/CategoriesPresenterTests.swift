//
//  CategoriesPresenterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class CategoriesPresenterTests: XCTestCase {
    private var interactor: CategoriesInteractorInputMock!
    private var view: CategoriesViewInputMock!
    private var router: CategoriesRouterInputMock!
    private lazy var presenter = CategoriesPresenter(view: view,
                                                     interactor: interactor,
                                                     router: router)

    override func setUp() {
        super.setUp()

        interactor = .init()
        view = .init()
        router = .init()
    }
    
    func testViewIsReady() {
        view.setTitleHandler = { title in
            XCTAssertEqual("News Categories", title)
        }
        
        presenter.viewIsReady()
        
        XCTAssertEqual(view.setTitleCallCount, 1)
        XCTAssertEqual(interactor.getCategoriesCallCount, 1)
    }
    
    func testDidGetCategories() {
        view.displayCategoriesHandler = { categories in
            XCTAssertEqual(categories.map({ $0.name }), ["Business"])
        }
        
        presenter.didGetCategories([.business])
        
        XCTAssertEqual(view.displayCategoriesCallCount, 1)
    }
    
    func testDidSelectCategoryAt() {
        interactor.getCategoryAtHandler = { index in
            XCTAssertEqual(index, 0)
        }
        
        presenter.didSelectCategoryAt(index: 0)
        
        XCTAssertEqual(interactor.getCategoryAtCallCount, 1)
    }
    
    func testDidGetCategory() {
        router.showCategoryHandler = { category in
            XCTAssertEqual(category, .business)
        }
        
        presenter.didGetCategory(.business)
        
        XCTAssertEqual(router.showCategoryCallCount, 1)
    }
}
