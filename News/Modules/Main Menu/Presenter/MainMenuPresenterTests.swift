//
//  MainMenuPresenterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import NewsDomain
@testable import News

final class MainMenuPresenterTests: XCTestCase {
    private var interactor: MainMenuInteractorInputMock!
    private var view: MainMenuViewInputMock!
    private var router: MainMenuRouterInputMock!
    private lazy var presenter = MainMenuPresenter(view: view,
                                                   interactor: interactor,
                                                   router: router)

    override func setUp() {
        super.setUp()

        interactor = .init()
        view = .init()
        router = .init()
    }

    func testStart() {
        presenter.start()
        
        XCTAssertEqual(interactor.getCountryCallCount, 1)
    }
    
    func testDidGetCountry() {
        router.showHeadlinesHandler = { country in
            XCTAssertEqual(country, .unitedStates)
        }

        presenter.didGetCountry(.unitedStates)
        
        XCTAssertEqual(router.showHeadlinesCallCount, 1)
    }
    
    func testdidGetNoCountry() {
        presenter.didGetCountry(nil)
        
        XCTAssertEqual(router.showCountrySelectionCallCount, 1)
    }
    
    func testDidSelectCountry() {
        router.showHeadlinesHandler = { country in
            XCTAssertEqual(country, .unitedStates)
        }

        presenter.didSelectCountry(.unitedStates)
        
        XCTAssertEqual(router.showHeadlinesCallCount, 1)
    }
}
