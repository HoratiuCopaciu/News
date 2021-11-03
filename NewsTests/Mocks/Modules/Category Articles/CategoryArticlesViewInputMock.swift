//
//  CategoryArticlesViewInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

@testable import News

final class CategoryArticlesViewInputMock: CategoryArticlesViewInput {
    init() { }

    private(set) var setTitleCallCount = 0
    var setTitleHandler: ((String) -> ())?
    func setTitle(_ title: String)  {
        setTitleCallCount += 1
        if let setTitleHandler = setTitleHandler {
            setTitleHandler(title)
        }
    }

    private(set) var displayArticlesCallCount = 0
    var displayArticlesHandler: (([CategoryArticleViewModel]) -> ())?
    func displayArticles(_ articles: [CategoryArticleViewModel])  {
        displayArticlesCallCount += 1
        if let displayArticlesHandler = displayArticlesHandler {
            displayArticlesHandler(articles)
        }
    }
}
