//
//  UIView+Constraints.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import UIKit

extension UIView {
    func constraint(into view: UIView) {
        guard isDescendant(of: view) else {
            fatalError("\(self) is not descendant of \(view)")
        }
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: view.topAnchor),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
}
