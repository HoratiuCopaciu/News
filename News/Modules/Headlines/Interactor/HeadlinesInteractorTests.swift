//
//  HeadlinesInteractorTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import NewsDomain
@testable import News

final class HeadlinesInteractorTests: XCTestCase {
    private var headlinesProvider: HeadlinesProviderProtocolMock!
    private var country: Country!
    private var output: HeadlinesInteractorOutputMock!
    private lazy var interactor: HeadlinesInteractor = {
        let interactor = HeadlinesInteractor(headlinesProvider: headlinesProvider,
                                                          country: country)
        interactor.output = output
        return interactor
    }()
    

    override func setUp() {
        super.setUp()

        headlinesProvider = .init()
        output = .init()
        country = .unitedStates
    }
    
    func testGetHeadlines() {
        headlinesProvider.getHeadlinesHandler = { country, completion in
            XCTAssertEqual(country, .unitedStates)
            completion(.success([]))
        }
        output.didGetHeadlinesHandler = { result in
            let articles = try? XCTUnwrap(result.get)
            XCTAssertNotNil(articles)
        }
        
        interactor.getHeadlines()
        
        XCTAssertEqual(headlinesProvider.getHeadlinesCallCount, 1)
        XCTAssertEqual(output.didGetHeadlinesCallCount, 1)
    }
    
    func testGetArticleAt() {
        let article = Article.stub()
        let articles = [article]
        headlinesProvider.getHeadlinesHandler = { country, completion in
            XCTAssertEqual(country, .unitedStates)
            completion(.success(articles))
        }
        output.didGetArticleHandler = { input in
            XCTAssertEqual(article, input)
        }

        interactor.getHeadlines()
        interactor.getArticleAt(index: 0)
        
        XCTAssertEqual(headlinesProvider.getHeadlinesCallCount, 1)
        XCTAssertEqual(output.didGetHeadlinesCallCount, 1)
        XCTAssertEqual(output.didGetArticleCallCount, 1)
    }
}
