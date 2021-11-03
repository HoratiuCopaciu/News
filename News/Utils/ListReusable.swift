//
//  ListReusable.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import UIKit

protocol ListReusable {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension ListReusable where Self: UIView {
    static var identifier: String {
        String(format: "%@%@", String(describing: self), "ReuseIdentifier")
    }
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}
