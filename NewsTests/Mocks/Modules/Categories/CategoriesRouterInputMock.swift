//
//  CategoriesRouterInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class CategoriesRouterInputMock: CategoriesRouterInput {
    init() { }

    private(set) var showCategoryCallCount = 0
    var showCategoryHandler: ((NewsCategory) -> ())?
    func showCategory(_ category: NewsCategory)  {
        showCategoryCallCount += 1
        if let showCategoryHandler = showCategoryHandler {
            showCategoryHandler(category)
        }
    }
}
