//
//  ArticlePresenterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import NewsDomain
@testable import News

final class ArticlePresenterTests: XCTestCase {
    private var interactor: ArticleInteractorInputMock!
    private var view: ArticleViewInputMock!
    private var imageLoader: ImageLoaderProtocolMock!
    private lazy var presenter = ArticlePresenter(view: view,
                                                  interactor: interactor,
                                                  imageLoader: imageLoader)
    override func setUp() {
        super.setUp()

        
        interactor = .init()
        view = .init()
        imageLoader = .init()
    }
    
    func testViewIsReady() {
        presenter.viewIsReady()
        
        XCTAssertEqual(view.startLoadingCallCount, 1)
        XCTAssertEqual(interactor.getArticleCallCount, 1)
    }
    
    func testDidGetArticleWithImageURL() throws {
        let url = try XCTUnwrap(URL(string: "https://domain.com"))
        let article = Article.stub(imageURL: url)
        
        imageLoader.downloadImageHandler = { imageURL, completion in
            XCTAssertEqual(imageURL, url)
            completion(nil)
        }
        view.displayArticleHandler = { viewModel in
            XCTAssertEqual(viewModel.title, article.title)
            XCTAssertEqual(viewModel.description, article.description)
            XCTAssertEqual(viewModel.content, article.content)
            if let author = article.author {
                XCTAssertEqual(viewModel.author, "Author: \(author)")
            } else {
                XCTAssertEqual(viewModel.author, "Unknown author")
            }
            
            XCTAssertNil(viewModel.image)
        }
        
        presenter.didGetArticle(article)
        
        XCTAssertEqual(imageLoader.downloadImageCallCount, 1)
        XCTAssertEqual(view.stopLoadingCallCount, 1)
        XCTAssertEqual(view.displayArticleCallCount, 1)
    }
    
    func testDidGetArticleWithoutImageURL() {
        let article = Article.stub()
        
        view.displayArticleHandler = { viewModel in
            XCTAssertEqual(viewModel.title, article.title)
            XCTAssertEqual(viewModel.description, article.description)
            XCTAssertEqual(viewModel.content, article.content)
            if let author = article.author {
                XCTAssertEqual(viewModel.author, "Author: \(author)")
            } else {
                XCTAssertEqual(viewModel.author, "Unknown author")
            }
            
            XCTAssertNil(viewModel.image)
        }
        
        presenter.didGetArticle(article)
        
        XCTAssertEqual(imageLoader.downloadImageCallCount, 0)
        XCTAssertEqual(view.stopLoadingCallCount, 1)
        XCTAssertEqual(view.displayArticleCallCount, 1)
    }
}
