//
//  HeadlinesPresenter.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain

final class HeadlinesPresenter {
    unowned var view: HeadlinesViewInput
    let interactor: HeadlinesInteractorInput
    let router: HeadlinesRouterInput

    init(view: HeadlinesViewInput,
         interactor: HeadlinesInteractorInput,
         router: HeadlinesRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - HeadlinesViewOutput

extension HeadlinesPresenter: HeadlinesViewOutput {
    func viewIsReady() {
        view.setTitle("Headlines")
        interactor.getHeadlines()
    }
    
    func didSelectArticleAt(index: Int) {
        interactor.getArticleAt(index: index)
    }
}

// MARK: - HeadlinesInteractorOutput
extension HeadlinesPresenter: HeadlinesInteractorOutput {
    func didGetHeadlines(result: Result<[Article], Error>) {
        switch result {
        case .success(let articles):
            let viewModel = articles.map({
                HeadlinesViewModel(title: $0.title, author: $0.author)
            })
            view.displayArticles(viewModel)
        case .failure:
            router.showAlert(with: "Could not load Headlines",
                             cancelTitle: "Cancel",
                             confirmationTitle: "Retry")
        }
    }
    
    func didGetArticle(_ article: Article) {
        router.showArticle(article)
    }
}

// MARK: - HeadlinesRouterOutput

extension HeadlinesPresenter: HeadlinesRouterOutput {
    func didSelectAlertConfirmation() {
        interactor.getHeadlines()
    }
    
    func didSelectAlertCancellation() {
        
    }
}
