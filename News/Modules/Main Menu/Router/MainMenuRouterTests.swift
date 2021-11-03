//
//  MainMenuRouterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class MainMenuRouterTests: XCTestCase {
    private var tabBarController: UITabBarController!
    private var output: MainMenuRouterOutputMock!
    private var headlinesBuilder: HeadlinesBuildableMock!
    private var categoriesBuilder: CategoriesBuildableMock!
private var countrySelectionBuilder: CountrySelectionBuildableMock!
    private lazy var router: MainMenuRouter = {
        let router = MainMenuRouter(tabBarController: tabBarController,
                                    countrySelectionBuilder: countrySelectionBuilder,
                                    headlinesBuilder: headlinesBuilder,
                                    categoriesBuilder: categoriesBuilder)
                                    
        router.output = output
        return router
    }()
    
    override func setUp() {
        super.setUp()

        tabBarController = .init()
        headlinesBuilder = .init()
        categoriesBuilder = .init()
        countrySelectionBuilder = .init()
        output = .init()
    }
    
    func testShowHeadlines() throws {
        let headlinesViewController = UIViewController()
        headlinesBuilder.buildHandler = { _, country -> UIViewController in
            XCTAssertEqual(country, .unitedStates)
            return headlinesViewController
        }
        
        let categoriesViewController = UIViewController()
        categoriesBuilder.buildHandler = { _ in
            categoriesViewController
        }
        
        router.showHeadlines(for: .unitedStates)
        
        let viewControllers = try XCTUnwrap(tabBarController.viewControllers as? [UINavigationController])
            .flatMap({ $0.viewControllers })
        
        XCTAssertEqual(viewControllers[0], headlinesViewController)
        XCTAssertEqual(viewControllers[1], categoriesViewController)
        XCTAssertEqual(headlinesBuilder.buildCallCount, 1)
        XCTAssertEqual(categoriesBuilder.buildCallCount, 1)
    }
    
    func testShowCountrySelection() {
        router.showCountrySelection()
        
        XCTAssertEqual(countrySelectionBuilder.buildCallCount, 1)
    }
}
