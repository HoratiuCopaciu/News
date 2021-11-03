//
//  CategoryArticlesBuildableMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

@testable import News
import NewsDomain
import UIKit

class CategoryArticlesBuildableMock: CategoryArticlesBuildable {
    init() { }


    private(set) var buildCallCount = 0
    var buildHandler: ((NewsCategory) -> (UIViewController))?
    func build(category: NewsCategory) -> UIViewController {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(category)
        }
        return UIViewController()
    }
}

