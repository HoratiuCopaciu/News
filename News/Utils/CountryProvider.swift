//
//  CountryProvider.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import NewsDomain
import Foundation

protocol CountryProviderProtocol {
    func getCountry() -> Country?
    func setCountry(_ country: Country)
}

final class CountryProvider: CountryProviderProtocol {
    private static let countryKey = "countryKey"
    private let storage: CountryStorageProtocol
    
    init(storage: CountryStorageProtocol) {
        self.storage = storage
    }

    func getCountry() -> Country? {
        storage.country(forKey: Self.countryKey)
    }
    
    func setCountry(_ country: Country) {
        storage.set(country, forKey: Self.countryKey)
    }
}

protocol CountryStorageProtocol {
    func set(_ country: Country, forKey key: String)
    func country(forKey key: String) -> Country?
}

extension UserDefaults: CountryStorageProtocol {
    func set(_ country: Country, forKey key: String) {
        set(country.rawValue, forKey: key)
    }
    
    func country(forKey key: String) -> Country? {
        guard let string = value(forKey: key) as? String,
              let country = Country(rawValue: string) else {
                  return nil
              }
        return country
    }
}
