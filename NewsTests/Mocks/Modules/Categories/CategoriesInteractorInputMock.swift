//
//  CategoriesInteractorInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News

final class CategoriesInteractorInputMock: CategoriesInteractorInput {
    init() { }

    private(set) var getCategoriesCallCount = 0
    var getCategoriesHandler: (() -> ())?
    func getCategories()  {
        getCategoriesCallCount += 1
        if let getCategoriesHandler = getCategoriesHandler {
            getCategoriesHandler()
        }
    }
    
    private(set) var getCategoryAtCallCount = 0
    var getCategoryAtHandler: ((Int) -> ())?
    func getCategoryAt(index: Int)  {
        getCategoryAtCallCount += 1
        if let getCategoryAtHandler = getCategoryAtHandler {
            getCategoryAtHandler(index)
        }
    }
}
