//
//  CountrySelectionInteractorTests.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News
import NewsDomain

final class CountrySelectionInteractorTests: XCTestCase {
    private var countryProvider: CountryProviderProtocolMock!
    private var output: CountrySelectionInteractorOutputMock!
    private lazy var interactor: CountrySelectionInteractor = {
        let interactor = CountrySelectionInteractor(countryProvider: countryProvider)
        interactor.output = output
        return interactor
    }()

    override func setUp() {
        super.setUp()

        countryProvider = .init()
        output = .init()
    }
    
    func testGetAvailableCountries() {
        output.didGetAvailableCountriesHandler = { countries in
            XCTAssertEqual(countries.count, Country.allCases.count)
        }
        
        interactor.getAvailableCountries()
        
        XCTAssertEqual(output.didGetAvailableCountriesCallCount, 1)
    }
    
    func testSetCountry() {
        let unitedState = Country.unitedStates
        countryProvider.setCountryHandler = { country in
            XCTAssertEqual(unitedState, country)
        }
        output.didSetCountryHandler = { country in
            XCTAssertEqual(unitedState, country)
        }
        
        interactor.setCountry(unitedState)
        
        XCTAssertEqual(countryProvider.setCountryCallCount, 1)
        XCTAssertEqual(output.didSetCountryCallCount, 1)
    }
}
