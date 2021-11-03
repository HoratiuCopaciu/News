//
//  HeadlinesBuilderTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import NewsDomain
import Networking
@testable import News

final class HeadlinesBuilderTests: XCTestCase {
    func testConfigure() throws {
        let dependency = MockDependency()
        let builder = HeadlinesBuilder(dependency: dependency)
        let controller = builder.build(navigationController: .init(),
                                       country: .argentina)

        let viewController = try XCTUnwrap(controller as? HeadlinesViewController)
        let presenter = try XCTUnwrap(viewController.output as? HeadlinesPresenter)
        let interactor = try XCTUnwrap(presenter.interactor as? HeadlinesInteractor)
        let router = try XCTUnwrap(presenter.router as? HeadlinesRouter)

        XCTAssertNotNil(viewController.output, "View output should be set")
        XCTAssertNotNil(interactor.output, "Interactor output should be set")
        XCTAssertNotNil(router.output, "Presenter output should be set")
    }

    private class MockDependency: HeadlinesDependency {
        let networkClient: NetworkClientProtocol = NetworkClientProtocolMock()
        let imageLoader: ImageLoaderProtocol = ImageLoaderProtocolMock()
    }
}
