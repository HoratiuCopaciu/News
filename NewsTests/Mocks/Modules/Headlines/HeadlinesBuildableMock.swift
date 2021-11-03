//
//  HeadlinesBuildableMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain
import UIKit

final class HeadlinesBuildableMock: HeadlinesBuildable {
    init() { }

    private(set) var buildCallCount = 0
    var buildHandler: ((UINavigationController, Country) -> (UIViewController))?
    func build(navigationController: UINavigationController, country: Country) -> UIViewController {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(navigationController, country)
        }
        return UIViewController()
    }
}
