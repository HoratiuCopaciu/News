//
//  AppDelegate.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import RIBs
import UIKit
import NewsDomain

@main
class AppDelegate: UIResponder {
    var window: UIWindow?
    private lazy var appComponent = AppComponent()
    private var launchInput: LaunchRouting?
    
    private func launch(from window: UIWindow?) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let routingInput = RootBuilder(dependency: appComponent).build()
        launchInput = routingInput
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
