//
//  CategoryArticlesPresenterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import NewsDomain
@testable import News

final class CategoryArticlesPresenterTests: XCTestCase {
    private var interactor: CategoryArticlesInteractorInputMock!
    private var view: CategoryArticlesViewInputMock!
    private lazy var presenter = CategoryArticlesPresenter(view: view,
                                                      interactor: interactor)

    override func setUp() {
        super.setUp()

        interactor = .init()
        view = .init()
    }
    
    func testViewIsReady() {
        presenter.viewIsReady()
        
        XCTAssertEqual(interactor.getArticlesCallCount, 1)
    }
    
    func testDidGetArticles() {
        let articles = [CategoryArticle.stub()]
        view.displayArticlesHandler = { input in
            XCTAssertEqual(input,
                           [.init(title: "description",
                                  author: "name")])
        }
        
        presenter.didGetArticles(result: .success(articles))
        
        XCTAssertEqual(view.displayArticlesCallCount, 1)
    }
    
    func testDidGetArticlesFailure() {
        presenter.didGetArticles(result: .failure(MockError()))
        
        XCTAssertEqual(view.displayArticlesCallCount, 0)
    }
}
