//
//  CategoriesInteractorOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class CategoriesInteractorOutputMock: CategoriesInteractorOutput {
    init() { }

    private(set) var didGetCategoriesCallCount = 0
    var didGetCategoriesHandler: (([NewsCategory]) -> ())?
    func didGetCategories(_ categories: [NewsCategory])  {
        didGetCategoriesCallCount += 1
        if let didGetCategoriesHandler = didGetCategoriesHandler {
            didGetCategoriesHandler(categories)
        }
    }
    
    private(set) var didGetCategoryCallCount = 0
    var didGetCategoryHandler: ((NewsCategory) -> ())?
    func didGetCategory(_ category: NewsCategory)  {
        didGetCategoryCallCount += 1
        if let didGetCategoryHandler = didGetCategoryHandler {
            didGetCategoryHandler(category)
        }
    }
}
