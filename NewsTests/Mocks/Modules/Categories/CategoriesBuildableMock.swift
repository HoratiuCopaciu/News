//
//  CategoriesBuildableMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import UIKit

final class CategoriesBuildableMock: CategoriesBuildable {
    init() { }

    private(set) var buildCallCount = 0
    var buildHandler: ((UINavigationController) -> (UIViewController))?
    func build(navigationController: UINavigationController) -> UIViewController {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(navigationController)
        }
        return UIViewController()
    }
}

