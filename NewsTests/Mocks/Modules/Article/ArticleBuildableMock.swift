//
//  ArticleBuildableMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

@testable import News
import UIKit
import NewsDomain

final class ArticleBuildableMock: ArticleBuildable {
    init() { }

    private(set) var buildCallCount = 0
    var buildHandler: ((Article) -> (UIViewController))?
    func build(article: Article) -> UIViewController {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(article)
        }
        return UIViewController()
    }
}

