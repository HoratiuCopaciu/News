//
//  HeadlinesViewInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News

final class HeadlinesViewInputMock: HeadlinesViewInput {
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
    var displayArticlesHandler: (([HeadlinesViewModel]) -> ())?
    func displayArticles(_ articles: [HeadlinesViewModel]) {
        displayArticlesCallCount += 1
        if let displayArticlesHandler = displayArticlesHandler {
            displayArticlesHandler(articles)
        }
    }

    private(set) var displayArticleCallCount = 0
    var displayArticleHandler: ((ArticleViewModel, Int) -> ())?
    func displayArticle(_ article: ArticleViewModel, at index: Int)  {
        displayArticleCallCount += 1
        if let displayArticleHandler = displayArticleHandler {
            displayArticleHandler(article, index)
        }
    }
}
