//
//  MainMenuInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

@testable import News

final class MainMenuInputMock: MainMenuInput {
    
    private(set) var startCallCount = 0
    var startHandler: (() -> Void)?
    func start() {
        startCallCount += 1
        startHandler?()
    }
}
