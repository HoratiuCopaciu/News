//
//  AppDelegate.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import UIKit
import NewsDomain

@main
class AppDelegate: UIResponder {
    lazy var window: UIWindow? = {
        UIWindow(frame: UIScreen.main.bounds)
    }()
    private lazy var appComponent = AppComponent()
    private var launchInput: LaunchInput?
    
    private func launch(from window: UIWindow?) {
        let (input, routingInput) = LaunchBuilder(dependency: appComponent).build()
        launchInput = input
        routingInput.launch(from: window)
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        launch(from: window)
        return true
    }
}
