//
//  RootViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    func present(_ viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    func setRootViewController(_ viewController: ViewControllable) {
        view.window?.rootViewController = viewController.uiviewController
    }
}
