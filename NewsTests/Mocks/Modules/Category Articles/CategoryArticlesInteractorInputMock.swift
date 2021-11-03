//
//  CategoryArticlesInteractorInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

@testable import News

final class CategoryArticlesInteractorInputMock: CategoryArticlesInteractorInput {
    init() { }

    private(set) var getArticlesCallCount = 0
    var getArticlesHandler: (() -> ())?
    func getArticles()  {
        getArticlesCallCount += 1
        if let getArticlesHandler = getArticlesHandler {
            getArticlesHandler()
        }
    }
}
