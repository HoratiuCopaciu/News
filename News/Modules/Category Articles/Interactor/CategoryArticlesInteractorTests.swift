//
//  CategoryArticlesInteractorTests.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import NewsDomain
@testable import News

final class CategoryArticlesInteractorTests: XCTestCase {
    private var categoriesProvider: CategoriesProviderProtocolMock!
    private var category: NewsCategory!
    private var output: CategoryArticlesInteractorOutputMock!
    private lazy var interactor: CategoryArticlesInteractor = {
        let interactor = CategoryArticlesInteractor(categoriesProvider: categoriesProvider,
                                                                 category: category)
        interactor.output = output
        return interactor
    }()

    override func setUp() {
        super.setUp()

        categoriesProvider = .init()
        output = .init()
        category = .business
    }
    
    func testGetArticles() {
        categoriesProvider.getArticlesHandler = { category, completion in
            XCTAssertEqual(category, .business)
            completion(.success([CategoryArticle.stub()]))
        }

        interactor.getArticles()
        
        XCTAssertEqual(output.didGetArticlesCallCount, 1)
    }
}
