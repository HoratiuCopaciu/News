//
//  LaunchPresenterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class LaunchPresenterTests: XCTestCase {
    private var interactor: MockInteractor!
    private var router: MockRouter!
    private lazy var presenter = LaunchPresenter(interactor: interactor,
                                                 router: router)

    override func setUp() {
        super.setUp()

        interactor = MockInteractor()
        router = MockRouter()
    }

    // MARK: - Utilities

    private class MockInteractor: LaunchInteractorInput {
        
    }

    private class MockRouter: LaunchRouterInput {

    }
}
