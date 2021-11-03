//
//  MainMenuInteractorOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class MainMenuInteractorOutputMock: MainMenuInteractorOutput {
    init() { }

    private(set) var didGetCountryCallCount = 0
    var didGetCountryHandler: ((Country?) -> ())?
    func didGetCountry(_ country: Country?)  {
        didGetCountryCallCount += 1
        if let didGetCountryHandler = didGetCountryHandler {
            didGetCountryHandler(country)
        }        
    }
}

