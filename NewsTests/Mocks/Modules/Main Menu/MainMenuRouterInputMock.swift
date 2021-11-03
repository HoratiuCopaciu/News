//
//  MainMenuRouterInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class MainMenuRouterInputMock: MainMenuRouterInput {
    init() { }

    private(set) var showHeadlinesCallCount = 0
    var showHeadlinesHandler: ((Country) -> ())?
    func showHeadlines(for country: Country)  {
        showHeadlinesCallCount += 1
        if let showHeadlinesHandler = showHeadlinesHandler {
            showHeadlinesHandler(country)
        }
    }

    private(set) var showCountrySelectionCallCount = 0
    var showCountrySelectionHandler: (() -> ())?
    func showCountrySelection()  {
        showCountrySelectionCallCount += 1
        if let showCountrySelectionHandler = showCountrySelectionHandler {
            showCountrySelectionHandler()
        }
    }
}
