//
//  CategoriesViewInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News

final class CategoriesViewInputMock: CategoriesViewInput {
    init() { }

    private(set) var setTitleCallCount = 0
    var setTitleHandler: ((String) -> ())?
    func setTitle(_ title: String)  {
        setTitleCallCount += 1
        if let setTitleHandler = setTitleHandler {
            setTitleHandler(title)
        }
    }

    private(set) var displayCategoriesCallCount = 0
    var displayCategoriesHandler: (([CategoryViewModel]) -> ())?
    func displayCategories(_ categories: [CategoryViewModel])  {
        displayCategoriesCallCount += 1
        if let displayCategoriesHandler = displayCategoriesHandler {
            displayCategoriesHandler(categories)
        }
    }
}
