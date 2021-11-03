//
//  LaunchRouterTests.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import News

final class LaunchRouterTests: XCTestCase {
    private var mainMenuBuilder: MainMenuBuildableMock!
    private lazy var router = LaunchRouter(mainMenuBuilder: mainMenuBuilder)
    
    override func setUp() {
        super.setUp()

        mainMenuBuilder = .init()
    }
    
    func testLaunch() {
        let window = UIWindow()
        let viewController = UIViewController()
        let input = MainMenuInputMock()
        mainMenuBuilder.buildHandler = {
            return (viewController, input)
        }
        
        router.launch(from: window)
        
        XCTAssertEqual(window.rootViewController, viewController)
        XCTAssertEqual(input.startCallCount, 1)
        XCTAssertEqual(mainMenuBuilder.buildCallCount, 1)
    }
}
