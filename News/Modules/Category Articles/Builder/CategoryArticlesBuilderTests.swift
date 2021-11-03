//
//  CategoryArticlesBuilderTests.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import Networking
@testable import News

final class CategoryArticlesBuilderTests: XCTestCase {
    func testConfigure() throws {
        let dependency = MockDependency()
        let builder = CategoryArticlesBuilder(dependency: dependency)
        let controller = builder.build(category: .business)

        let viewController = try XCTUnwrap(controller as? CategoryArticlesViewController)
        let presenter = try XCTUnwrap(viewController.output as? CategoryArticlesPresenter)
        let interactor = try XCTUnwrap(presenter.interactor as? CategoryArticlesInteractor)

        XCTAssertNotNil(viewController.output, "View output should be set")
        XCTAssertNotNil(interactor.output, "Interactor output should be set")
    }

    private class MockDependency: CategoryArticlesDependency {
        let networkClient: NetworkClientProtocol = NetworkClientProtocolMock()
        let categoriesProvider: CategoriesProviderProtocol = CategoriesProviderProtocolMock()
    }
}
