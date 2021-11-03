//
//  MainMenuBuildableMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

@testable import News
import UIKit

final class MainMenuBuildableMock: MainMenuBuildable {
    init() {}

    private(set) var buildCallCount = 0
    var buildHandler: (() -> (UIViewController, MainMenuInput))?
    func build() -> (UIViewController, MainMenuInput) {
        buildCallCount += 1
        if let buildHandler = buildHandler?() {
            return buildHandler
        }
        fatalError()
    }
}
