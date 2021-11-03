//
//  ArticleRepresentable.swift
//  
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

import Foundation

public protocol ArticleRepresentable {
    var title: String { get }
    var description: String { get }
    var provider: String? { get }
}
