//
//  HeadlinesRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain

protocol HeadlinesRouterInput {
    func showAlert(with message: String,
                   cancelTitle: String,
                   confirmationTitle: String)
    func showArticle(_ article: Article)
}

protocol HeadlinesRouterOutput: AnyObject {
    func didSelectAlertConfirmation()
    func didSelectAlertCancellation()
}

final class HeadlinesRouter {
    weak var output: HeadlinesRouterOutput?
    private unowned var navigationController: UINavigationController
    private let articleBuilder: ArticleBuildable
    
    init(navigationController: UINavigationController,
         articleBuilder: ArticleBuildable) {
        self.navigationController = navigationController
        self.articleBuilder = articleBuilder
    }
}

// MARK: - HeadlinesRouterInput

extension HeadlinesRouter: HeadlinesRouterInput {
    func showAlert(with message: String,
                   cancelTitle: String,
                   confirmationTitle: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: cancelTitle, style: .cancel, handler: { [weak output] _ in
            output?.didSelectAlertConfirmation()
        }))
        alert.addAction(.init(title: confirmationTitle, style: .default, handler: { [weak output] _ in
            output?.didSelectAlertCancellation()
        }))
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func showArticle(_ article: Article) {
        let viewController = articleBuilder.build(article: article)
        navigationController.pushViewController(viewController, animated: true)
    }
}
