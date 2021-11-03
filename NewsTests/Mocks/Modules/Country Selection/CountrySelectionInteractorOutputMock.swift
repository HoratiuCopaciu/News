//
//  CountrySelectionInteractorOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class CountrySelectionInteractorOutputMock: CountrySelectionInteractorOutput {
    init() { }

    private(set) var didSetCountryCallCount = 0
    var didSetCountryHandler: ((Country) -> ())?
    func didSetCountry(_ country: Country)  {
        didSetCountryCallCount += 1
        if let didSetCountryHandler = didSetCountryHandler {
            didSetCountryHandler(country)
        }
    }

    private(set) var didGetAvailableCountriesCallCount = 0
    var didGetAvailableCountriesHandler: (([Country]) -> ())?
    func didGetAvailableCountries(_ countries: [Country])  {
        didGetAvailableCountriesCallCount += 1
        if let didGetAvailableCountriesHandler = didGetAvailableCountriesHandler {
            didGetAvailableCountriesHandler(countries)
        }
    }
}
