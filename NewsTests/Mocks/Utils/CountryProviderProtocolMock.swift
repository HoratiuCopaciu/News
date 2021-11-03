//
//  CountryProviderProtocolMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

import Foundation
import NewsDomain
import UIKit
@testable import News

final class CountryProviderProtocolMock: CountryProviderProtocol {
    init() { }

    private(set) var getCountryCallCount = 0
    var getCountryHandler: (() -> (Country?))?
    func getCountry() -> Country? {
        getCountryCallCount += 1
        if let getCountryHandler = getCountryHandler {
            return getCountryHandler()
        }
        return nil
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


