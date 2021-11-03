//
//  CountrySelectionPresenterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News
import NewsDomain

final class CountrySelectionPresenterTests: XCTestCase {
    private var interactor: CountrySelectionInteractorInputMock!
    private var view: CountrySelectionViewInputMock!
    private var completionHandler: CountrySelectionCompletionHandler!
    private var completionCallCount = 0
    private lazy var presenter = CountrySelectionPresenter(view: view,
                                                           interactor: interactor,
                                                           completionHandler: completionHandler)
    
    override func setUp() {
        super.setUp()
        
        interactor = .init()
        view = .init()
        completionCallCount = 0
        completionHandler = { [weak self] _ in
            self?.completionCallCount += 1
        }
    }
    
    func testViewIsReady() {
        view.setTitleHandler = { title in
            XCTAssertEqual(title, "Select Country")
        }
        
        presenter.viewIsReady()
        
        XCTAssertEqual(view.setTitleCallCount, 1)
        XCTAssertEqual(interactor.getAvailableCountriesCallCount, 1)
    }
    
    func testDidSelectCountry() {
        let country = Country.unitedStates
        interactor.setCountryHandler = { input in
            XCTAssertEqual(input, country)
        }
        
        presenter.didSelectCountry(name: country.rawValue)
        
        XCTAssertEqual(interactor.setCountryCallCount, 1)
    }
    
    func testDidGetAvailableCountries() {
        let country = Country.unitedStates
        view.displayCountiesHandler = { names in
            XCTAssertEqual(names, [country.rawValue])
        }
        
        presenter.didGetAvailableCountries([country])
        
        XCTAssertEqual(view.displayCountiesCallCount, 1)
    }
    
    func testDidSetCountry() {
        let unitedStates = Country.unitedStates
        completionHandler = { [weak self] country in
            self?.completionCallCount += 1
            XCTAssertEqual(country, unitedStates)
        }
        
        presenter.didSetCountry(unitedStates)
        
        XCTAssertEqual(completionCallCount, 1)
    }
}
