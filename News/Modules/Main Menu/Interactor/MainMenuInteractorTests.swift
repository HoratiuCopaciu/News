//
//  MainMenuInteractorTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class MainMenuInteractorTests: XCTestCase {
    private var countryProvider: CountryProviderProtocolMock!
    private var output: MainMenuInteractorOutputMock!
    private lazy var interactor: MainMenuInteractor = {
        let interactor = MainMenuInteractor(countryProvider: countryProvider)
        interactor.output = output
        return interactor
    }()

    override func setUp() {
        super.setUp()

        countryProvider = .init()
        output = .init()
    }
    
    func testGetCountry() {
        countryProvider.getCountryHandler = { .unitedStates }
        output.didGetCountryHandler = { country in
            XCTAssertEqual(country, .unitedStates)
        }

        interactor.getCountry()
        
        XCTAssertEqual(output.didGetCountryCallCount, 1)
    }
}
