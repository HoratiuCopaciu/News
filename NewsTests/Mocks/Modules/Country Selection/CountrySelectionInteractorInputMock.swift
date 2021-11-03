//
//  CountrySelectionInteractorInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class CountrySelectionInteractorInputMock: CountrySelectionInteractorInput {
    init() { }

    private(set) var getAvailableCountriesCallCount = 0
    var getAvailableCountriesHandler: (() -> ())?
    func getAvailableCountries()  {
        getAvailableCountriesCallCount += 1
        if let getAvailableCountriesHandler = getAvailableCountriesHandler {
            getAvailableCountriesHandler()
        }
    }

    private(set) var setCountryCallCount = 0
    var setCountryHandler: ((Country) -> ())?
    func setCountry(_ country: Country)  {
        setCountryCallCount += 1
        if let setCountryHandler = setCountryHandler {
            setCountryHandler(country)
        }
    }
}

