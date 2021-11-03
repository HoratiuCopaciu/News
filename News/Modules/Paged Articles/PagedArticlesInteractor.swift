//
//  PagedArticlesInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 07.11.2021.
//

import RIBs
import RxSwift
import NewsDomain

protocol PagedArticlesRouting: ViewableRouting {
    func getController(forArticle article: Article) -> PagedArticleViewControllable?
}

protocol PagedArticlesPresentable: Presentable {
    var listener: PagedArticlesPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol PagedArticlesListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class PagedArticlesInteractor: PresentableInteractor<PagedArticlesPresentable>, PagedArticlesInteractable, PagedArticlesPresentableListener {

    weak var router: PagedArticlesRouting?
    weak var listener: PagedArticlesListener?
    private let headlinesProvider: HeadlinesProviderProtocol
    private let country: Country
    private var articles: [Article]?
    
    init(presenter: PagedArticlesPresentable,
         headlinesProvider: HeadlinesProviderProtocol,
         country: Country) {
        self.headlinesProvider = headlinesProvider
        self.country = country
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        headlinesProvider.getHeadlines(forCountry: country,
                                       completion: { [weak self] result in
            self?.articles = try? result.get()
        })
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func getController(atIndex index: Int?) -> ViewControllable? {
        guard let index = index,
              index >= 0,
              let articles = articles,
              index < articles.count else {
                  return nil
              }
        let controller = router?.getController(forArticle: articles[index])
        controller?.index = index
        return controller
    }
    
    func getController(beforeIndex index: Int?) -> ViewControllable? {
        guard let index = index,
              index > 0,
              let articles = articles,
              index < articles.count else {
                  return nil
              }
        
        
        let controller = router?.getController(forArticle: articles[index - 1])
        controller?.index = index - 1
        return controller
    }
    
    func getController(afterIndex index: Int?) -> ViewControllable? {
        guard let index = index,
              let articles = articles,
              index < articles.count else {
                  return nil
              }
        let controller = router?.getController(forArticle: articles[index + 1])
        controller?.index = index + 1
        return controller
    }
}
