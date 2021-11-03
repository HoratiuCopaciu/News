//
//  CategoriesViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol CategoriesPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CategoriesViewController: UIViewController, CategoriesPresentable, CategoriesViewControllable {

    weak var listener: CategoriesPresentableListener?
}
