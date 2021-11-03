//
//  MainMenuViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 05.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol MainMenuPresentableListener: AnyObject {
    func getCountry()
}

enum MainMenuTabBarItem: Int, CaseIterable {
    case headlines
    case categories
}

final class MainMenuViewController: UITabBarController, MainMenuPresentable, MainMenuViewControllable {

    weak var listener: MainMenuPresentableListener?
    
    func setViewControllers(_ viewControllers: [ViewControllable]) {
        self.viewControllers = viewControllers.map({ $0.uiviewController })
    }
    
    func present(_ viewController: ViewControllable) {
        self.present(viewController.uiviewController,
                     animated: true,
                     completion: nil)
    }
    
    func dismiss(completion: (() -> Void)?) {
        self.dismiss(animated: true, completion: completion)
    }
}
