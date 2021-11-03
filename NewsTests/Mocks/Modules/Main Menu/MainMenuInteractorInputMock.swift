//
//  MainMenuInteractorInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News

final class MainMenuInteractorInputMock: MainMenuInteractorInput {
    init() { }

    private(set) var getCountryCallCount = 0
    var getCountryHandler: (() -> ())?
    func getCountry()  {
        getCountryCallCount += 1
        if let getCountryHandler = getCountryHandler {
            getCountryHandler()
        }
    }
}
