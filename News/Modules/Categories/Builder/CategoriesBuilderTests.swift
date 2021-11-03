//
//  CategoriesBuilderTests.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import Networking
@testable import News

final class CategoriesBuilderTests: XCTestCase {
    func testConfigure() throws {
        let dependency = MockDependency()
        let builder = CategoriesBuilder(dependency: dependency)
        let controller = builder.build(navigationController: .init())
        let viewController = try XCTUnwrap(controller as? CategoriesViewController)
        let presenter = try XCTUnwrap(viewController.output as? CategoriesPresenter)
        let interactor = try XCTUnwrap(presenter.interactor as? CategoriesInteractor)
        let router = try XCTUnwrap(presenter.router as? CategoriesRouter)

        XCTAssertNotNil(viewController.output, "View output should be set")
        XCTAssertNotNil(interactor.output, "Interactor output should be set")
        XCTAssertNotNil(router.output, "Presenter output should be set")
    }

    private class MockDependency: CategoriesDependency {
        let networkClient: NetworkClientProtocol = NetworkClientProtocolMock()
    }
}
