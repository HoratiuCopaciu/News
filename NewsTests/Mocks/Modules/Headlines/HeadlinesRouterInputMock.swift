//
//  HeadlinesRouterInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class HeadlinesRouterInputMock: HeadlinesRouterInput {
    init() { }

    private(set) var showAlertCallCount = 0
    var showAlertHandler: ((String, String, String) -> ())?
    func showAlert(with message: String, cancelTitle: String, confirmationTitle: String)  {
        showAlertCallCount += 1
        if let showAlertHandler = showAlertHandler {
            showAlertHandler(message, cancelTitle, confirmationTitle)
        }
    }

    private(set) var showArticleCallCount = 0
    var showArticleHandler: ((Article) -> ())?
    func showArticle(_ article: Article)  {
        showArticleCallCount += 1
        if let showArticleHandler = showArticleHandler {
            showArticleHandler(article)
        }
    }
}
