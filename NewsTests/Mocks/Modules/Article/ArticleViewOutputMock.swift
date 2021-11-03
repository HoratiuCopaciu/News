//
//  ArticleViewOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

@testable import News

final class ArticleViewOutputMock: ArticleViewOutput {
    init() { }

    private(set) var viewIsReadyCallCount = 0
    var viewIsReadyHandler: (() -> ())?
    func viewIsReady()  {
        viewIsReadyCallCount += 1
        if let viewIsReadyHandler = viewIsReadyHandler {
            viewIsReadyHandler()
        }
    }
}
