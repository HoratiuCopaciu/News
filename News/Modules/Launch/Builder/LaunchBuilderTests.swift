//
//  LaunchBuilderTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import News
import XCTest

final class LaunchBuilderTests: XCTestCase {
    func testConfigure() throws {
        let dependency = MockDependency()
        let builder = LaunchBuilder(dependency: dependency)
        let (input, launchInput) = builder.build()
        
        let router = try XCTUnwrap(launchInput as? LaunchRouter)
        let presenter = try XCTUnwrap(input as? LaunchPresenter)
        let interactor = try XCTUnwrap(presenter.interactor as? LaunchInteractor)

        XCTAssertNotNil(interactor.output, "Interactor output should be set")
        XCTAssertNotNil(router.output, "Presenter output should be set")
    }

    private class MockDependency: LaunchDependency {
        
    }
}
