//
//  CategoryArticlesInteractorOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

@testable import News
import NewsDomain

final class CategoryArticlesInteractorOutputMock: CategoryArticlesInteractorOutput {
    init() { }

    private(set) var didGetArticlesCallCount = 0
    var didGetArticlesHandler: ((Result<[CategoryArticle], Error>) -> ())?
    func didGetArticles(result: Result<[CategoryArticle], Error>)  {
        didGetArticlesCallCount += 1
        if let didGetArticlesHandler = didGetArticlesHandler {
            didGetArticlesHandler(result)
        }
    }
}
