//
//  HeadlinesRouterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class HeadlinesRouterTests: XCTestCase {
    private var navigationController: UINavigationController!
    private var articleBuilder: ArticleBuildableMock!
    private var output: HeadlinesRouterOutputMock!
    private lazy var router: HeadlinesRouter = {
        let router = HeadlinesRouter(navigationController: navigationController,
                                     articleBuilder: articleBuilder)
        router.output = output
        return router
    }()

    override func setUp() {
        super.setUp()

        navigationController = .init()
        articleBuilder = .init()
        output = .init()
    }
    
    func testShowAlert() throws {
//        let alertController = UIAlertController()
//
//        router.showAlert(with: "message",
//                         cancelTitle: "cancel",
//                         confirmationTitle: "confrim")
//
//        XCTAssertEqual(alertController.message, "message")
//        XCTAssertEqual(alertController.preferredStyle, .alert)
    }
}
