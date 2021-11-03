//
//  MainMenuRouterOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class MainMenuRouterOutputMock: MainMenuRouterOutput {
    init() { }

    private(set) var didSelectCountryCallCount = 0
    var didSelectCountryHandler: ((Country) -> ())?
    func didSelectCountry(_ country: Country)  {
        didSelectCountryCallCount += 1
        if let didSelectCountryHandler = didSelectCountryHandler {
            didSelectCountryHandler(country)
        }
    }
}

