//
//  HeadlinesRouterOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class HeadlinesRouterOutputMock: HeadlinesRouterOutput {
    init() { }

    private(set) var didSelectAlertConfirmationCallCount = 0
    var didSelectAlertConfirmationHandler: (() -> ())?
    func didSelectAlertConfirmation()  {
        didSelectAlertConfirmationCallCount += 1
        if let didSelectAlertConfirmationHandler = didSelectAlertConfirmationHandler {
            didSelectAlertConfirmationHandler()
        }
    }

    private(set) var didSelectAlertCancellationCallCount = 0
    var didSelectAlertCancellationHandler: (() -> ())?
    func didSelectAlertCancellation()  {
        didSelectAlertCancellationCallCount += 1
        if let didSelectAlertCancellationHandler = didSelectAlertCancellationHandler {
            didSelectAlertCancellationHandler()
        }
    }
}
