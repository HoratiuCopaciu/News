//
//  ArticleViewInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

@testable import News

final class ArticleViewInputMock: ArticleViewInput {
    init() { }

    private(set) var startLoadingCallCount = 0
    var startLoadingHandler: (() -> ())?
    func startLoading()  {
        startLoadingCallCount += 1
        if let startLoadingHandler = startLoadingHandler {
            startLoadingHandler()
        }
    }

    private(set) var stopLoadingCallCount = 0
    var stopLoadingHandler: (() -> ())?
    func stopLoading()  {
        stopLoadingCallCount += 1
        if let stopLoadingHandler = stopLoadingHandler {
            stopLoadingHandler()
        }
    }

    private(set) var displayArticleCallCount = 0
    var displayArticleHandler: ((ArticleViewModel) -> ())?
    func displayArticle(_ article: ArticleViewModel)  {
        displayArticleCallCount += 1
        if let displayArticleHandler = displayArticleHandler {
            displayArticleHandler(article)
        }
    }
}
