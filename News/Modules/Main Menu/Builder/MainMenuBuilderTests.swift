//
//  MainMenuBuilderTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class MainMenuBuilderTests: XCTestCase {
    func testConfigure() throws {
        let dependency = MockDependency()
        let builder = MainMenuBuilder(dependency: dependency)
        let (controller, input) = builder.build()

        let viewController = try XCTUnwrap(controller as? MainMenuViewController)
        let presenter = try XCTUnwrap(input as? MainMenuPresenter)
        let interactor = try XCTUnwrap(presenter.interactor as? MainMenuInteractor)
        let router = try XCTUnwrap(presenter.router as? MainMenuRouter)

        XCTAssertNotNil(viewController.output, "View output should be set")
        XCTAssertNotNil(interactor.output, "Interactor output should be set")
        XCTAssertNotNil(router.output, "Presenter output should be set")
    }

    private class MockDependency: MainMenuDependency {
        
    }
}
