//
//  CountrySelectionBuildableMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import UIKit

final class CountrySelectionBuildableMock: CountrySelectionBuildable {
    init() { }


    private(set) var buildCallCount = 0
    var buildHandler: ((@escaping CountrySelectionCompletionHandler) -> (UIViewController))?
    func build(handler: @escaping CountrySelectionCompletionHandler) -> UIViewController {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(handler)
        }
        return UIViewController()
    }
}

