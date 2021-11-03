//
//  CountrySelectionViewInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News

final class CountrySelectionViewInputMock: CountrySelectionViewInput {
    init() { }

    private(set) var setTitleCallCount = 0
    var setTitleHandler: ((String) -> ())?
    func setTitle(_ title: String)  {
        setTitleCallCount += 1
        if let setTitleHandler = setTitleHandler {
            setTitleHandler(title)
        }
    }

    private(set) var displayCountiesCallCount = 0
    var displayCountiesHandler: (([String]) -> ())?
    func displayCounties(names: [String])  {
        displayCountiesCallCount += 1
        if let displayCountiesHandler = displayCountiesHandler {
            displayCountiesHandler(names)
        }
    }
}
