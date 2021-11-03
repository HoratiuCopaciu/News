//
//  PagedArticlesViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 07.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol PagedArticleViewControllable: ViewControllable {
    var index: Int { get set }
}

protocol PagedArticlesPresentableListener: AnyObject {
    func getController(atIndex index: Int?) -> ViewControllable?
    func getController(beforeIndex index: Int?) -> ViewControllable?
    func getController(afterIndex index: Int?) -> ViewControllable?
}

final class PagedArticlesViewController: UIPageViewController, PagedArticlesPresentable, PagedArticlesViewControllable {

    weak var listener: PagedArticlesPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        
        if let controller = listener?.getController(atIndex: 0) {
            setViewControllers([controller.uiviewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}

extension PagedArticlesViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = (viewController as? PagedArticleViewControllable)?.index
        return listener?.getController(beforeIndex: index)?.uiviewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = (viewController as? PagedArticleViewControllable)?.index
        return listener?.getController(afterIndex: index)?.uiviewController
    }
}

private extension UIPageViewController {
    func firstIndex(of viewController: UIViewController) -> Int? {
        viewControllers?.firstIndex(of: viewController)
    }
}
