//
//  HeadlinesPresenterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import NewsDomain
@testable import News

final class HeadlinesPresenterTests: XCTestCase {
    private var interactor: HeadlinesInteractorInputMock!
    private var view: HeadlinesViewInputMock!
    private var router: HeadlinesRouterInputMock!
    private lazy var presenter = HeadlinesPresenter(view: view,
                                                    interactor: interactor,
                                                    router: router)

    override func setUp() {
        super.setUp()

        interactor = .init()
        view = .init()
        router = .init()
    }
    
    func testDidSelectArticle() {
        interactor.getArticleAtHandler = { index in
            XCTAssertEqual(index, 0)
        }
        
        presenter.didSelectArticleAt(index: 0)
        
        XCTAssertEqual(interactor.getArticleAtCallCount, 1)
    }
    
    func testDidGetArticle() {
        let article = Article.stub()
        router.showArticleHandler = { input in
            XCTAssertEqual(article, input)
        }
        
        presenter.didGetArticle(article)
        
        XCTAssertEqual(router.showArticleCallCount, 1)
    }
    
    func testDidGetHeadlines() {
        let article = Article.stub()
        
        view.displayArticlesHandler = { input in
            let viewModel = input.first
            XCTAssertEqual(article.title, viewModel?.title)
            XCTAssertEqual(article.author, viewModel?.author)
        }
        
        presenter.didGetHeadlines(result: .success([article]))
        
        XCTAssertEqual(view.displayArticlesCallCount, 1)
    }
    
    func testDidGetHeadlinesFailure() {
        router.showAlertHandler = { message, cancel, confirm in
            XCTAssertEqual(message, "Could not load Headlines")
            XCTAssertEqual(cancel, "Cancel")
            XCTAssertEqual(confirm, "Retry")
        }

        presenter.didGetHeadlines(result: .failure(MockError()))
        
        XCTAssertEqual(router.showAlertCallCount, 1)
    }
    
    func testDidSelectAlertConfirmation() {
        presenter.didSelectAlertConfirmation()
        
        XCTAssertEqual(interactor.getHeadlinesCallCount, 1)
    }
}
