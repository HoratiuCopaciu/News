//
//  CountrySelectionViewOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News

final class CountrySelectionViewOutputMock: CountrySelectionViewOutput {
    init() { }

    private(set) var viewIsReadyCallCount = 0
    var viewIsReadyHandler: (() -> ())?
    func viewIsReady()  {
        viewIsReadyCallCount += 1
        if let viewIsReadyHandler = viewIsReadyHandler {
            viewIsReadyHandler()
        }
    }

    private(set) var didSelectCountryCallCount = 0
    var didSelectCountryHandler: ((String) -> ())?
    func didSelectCountry(name: String)  {
        didSelectCountryCallCount += 1
        if let didSelectCountryHandler = didSelectCountryHandler {
            didSelectCountryHandler(name)
        }
    }
}
