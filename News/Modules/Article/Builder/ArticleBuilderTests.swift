//
//  ArticleBuilderTests.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import Networking
@testable import News

final class ArticleBuilderTests: XCTestCase {
    func testConfigure() throws {
        let dependency = MockDependency()
        let builder = ArticleBuilder(dependency: dependency)
        let controller = builder.build(article: .stub())

        let viewController = try XCTUnwrap(controller as? ArticleViewController)
        let presenter = try XCTUnwrap(viewController.output as? ArticlePresenter)
        let interactor = try XCTUnwrap(presenter.interactor as? ArticleInteractor)

        XCTAssertNotNil(viewController.output, "View output should be set")
        XCTAssertNotNil(interactor.output, "Interactor output should be set")
    }

    private class MockDependency: ArticleDependency {
        let networkClient: NetworkClientProtocol = NetworkClientProtocolMock()
    }
}
