//
//  CountrySelectionBuilderTests.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class CountrySelectionBuilderTests: XCTestCase {
    func testConfigure() throws {
        let dependency = MockDependency()
        let builder = CountrySelectionBuilder(dependency: dependency)
        let controller = builder.build(handler: { _ in })

        let viewController = try XCTUnwrap(controller as? CountrySelectionViewController)
        let presenter = try XCTUnwrap(viewController.output as? CountrySelectionPresenter)
        let interactor = try XCTUnwrap(presenter.interactor as? CountrySelectionInteractor)

        XCTAssertNotNil(viewController.output, "View output should be set")
        XCTAssertNotNil(interactor.output, "Interactor output should be set")
    }

    private class MockDependency: CountrySelectionDependency {
        let countryProvider: CountryProviderProtocol = CountryProviderProtocolMock()
    }
}
