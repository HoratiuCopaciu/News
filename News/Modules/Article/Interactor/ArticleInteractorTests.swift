//
//  ArticleInteractorTests.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import NewsDomain
@testable import News

final class ArticleInteractorTests: XCTestCase {
    private var article: Article!
    private var output: ArticleInteractorOutputMock!
    private lazy var interactor: ArticleInteractor = {
        let interactor = ArticleInteractor(article: article)
        interactor.output = output
        return interactor
    }()

    override func setUp() {
        super.setUp()

        article = .stub()
        output = .init()
    }
    
    func testGetArticle() {
        output.didGetArticleHandler = { [weak self] article in
            XCTAssertEqual(article, self?.article)
        }
        
        interactor.getArticle()
        
        XCTAssertEqual(output.didGetArticleCallCount, 1)
    }
}
