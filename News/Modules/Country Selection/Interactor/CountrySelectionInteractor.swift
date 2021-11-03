//
//  CountrySelectionInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 31.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain

protocol CountrySelectionInteractorInput: AnyObject {
    func getAvailableCountries()
    func setCountry(_ country: Country)
}

protocol CountrySelectionInteractorOutput: AnyObject {
    func didSetCountry(_ country: Country)
    func didGetAvailableCountries(_ countries: [Country])
}

final class CountrySelectionInteractor {
    weak var output: CountrySelectionInteractorOutput?

    private let countryProvider: CountryProviderProtocol
    
    init(countryProvider: CountryProviderProtocol) {
        self.countryProvider = countryProvider
    }
}

// MARK: - CountrySelectionInteractorInput

extension CountrySelectionInteractor: CountrySelectionInteractorInput {
    func getAvailableCountries() {
        output?.didGetAvailableCountries(Country.allCases)
    }

    func setCountry(_ country: Country) {
        countryProvider.setCountry(country)
        output?.didSetCountry(country)
    }
}
