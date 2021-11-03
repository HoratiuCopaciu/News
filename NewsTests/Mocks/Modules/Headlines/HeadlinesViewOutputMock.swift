//
//  HeadlinesViewOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News

final class HeadlinesViewOutputMock: HeadlinesViewOutput {
    init() { }

    private(set) var viewIsReadyCallCount = 0
    var viewIsReadyHandler: (() -> ())?
    func viewIsReady()  {
        viewIsReadyCallCount += 1
        if let viewIsReadyHandler = viewIsReadyHandler {
            viewIsReadyHandler()
        }
    }

    private(set) var getImageAtCallCount = 0
    var getImageAtHandler: ((Int) -> ())?
    func getImageAt(index: Int)  {
        getImageAtCallCount += 1
        if let getImageAtHandler = getImageAtHandler {
            getImageAtHandler(index)
        }
    }

    private(set) var cancelGetImageAtCallCount = 0
    var cancelGetImageAtHandler: ((Int) -> ())?
    func cancelGetImageAt(index: Int)  {
        cancelGetImageAtCallCount += 1
        if let cancelGetImageAtHandler = cancelGetImageAtHandler {
            cancelGetImageAtHandler(index)
        }
    }

    private(set) var didSelectArticleAtCallCount = 0
    var didSelectArticleAtHandler: ((Int) -> ())?
    func didSelectArticleAt(index: Int)  {
        didSelectArticleAtCallCount += 1
        if let didSelectArticleAtHandler = didSelectArticleAtHandler {
            didSelectArticleAtHandler(index)
        }
    }
}
