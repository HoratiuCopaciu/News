//
//  MainMenuViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainMenuViewInput: AnyObject {
}

protocol MainMenuViewOutput: AnyObject {
    func didSelectItemAtIndex(_ index: Int)
}

enum MainMenuTabBarItem: Int, CaseIterable {
    case home
    case categories
    case favorites
    case profile
}

final class MainMenuViewController: UITabBarController {
    var output: MainMenuViewOutput?
    var didSelectItemAtIndex: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MainMenuViewController: MainMenuViewInput {
}

extension MainMenuViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        output?.didSelectItemAtIndex(tabBarController.selectedIndex)
    }
}
