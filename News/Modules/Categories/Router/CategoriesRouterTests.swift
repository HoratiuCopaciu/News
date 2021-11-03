//
//  CategoriesRouterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class CategoriesRouterTests: XCTestCase {
    private var navigationController: UINavigationController!
    private var categoryArticlesBuilder: CategoryArticlesBuildableMock!
    private lazy var router: CategoriesRouter = {
        let router = CategoriesRouter(navigationController: navigationController,
                                      categoryArticlesBuilder: categoryArticlesBuilder)
        return router
    }()

    override func setUp() {
        super.setUp()

        navigationController = .init()
        categoryArticlesBuilder = .init()
    }
    
    func testShowCategory() {
        
    }
}
