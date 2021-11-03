//
//  HeadlinesInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import RxSwift
import NewsDomain

protocol HeadlinesRouting: ViewableRouting {
    func routeToHeadline(_ article: Article)
}

protocol HeadlinesPresentable: Presentable {
    var listener: HeadlinesPresentableListener? { get set }
    
    func showHeadlines(articles: [HeadlinesViewModel])
}

protocol HeadlinesListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class HeadlinesInteractor: PresentableInteractor<HeadlinesPresentable>, HeadlinesInteractable {

    weak var router: HeadlinesRouting?
    weak var listener: HeadlinesListener?
    private let headlinesProvider: HeadlinesProviderProtocol
    private let country: Country
    private var articles: [Article]?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: HeadlinesPresentable,
         headlinesProvider: HeadlinesProviderProtocol,
         country: Country) {
        self.headlinesProvider = headlinesProvider
        self.country = country
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
     
        loadHeadlines()
    }
}

extension HeadlinesInteractor: HeadlinesPresentableListener {
    func didSelectArticleAt(index: Int) {
        guard let articles = articles,
              index < articles.count else {
                  return
              }
        let article = articles[index]
        router?.routeToHeadline(article)
    }
    
    func refresh() {
        loadHeadlines()
    }
}

private extension HeadlinesInteractor {
    private func loadHeadlines() {
        getHeadlines(completion: { [weak presenter] articles in
            let headlines = articles.map({
                HeadlinesViewModel(title: $0.title,
                                   author: $0.author)
            })
            presenter?.showHeadlines(articles: headlines)
        })
    }
    
    func getHeadlines(completion: @escaping ([Article]) -> Void) {
        headlinesProvider.getHeadlines(forCountry: country,
                                       completion: { [weak self] result in
            self?.articles = try? result.get()
            completion(self?.articles ?? [])
        })
    }
}
