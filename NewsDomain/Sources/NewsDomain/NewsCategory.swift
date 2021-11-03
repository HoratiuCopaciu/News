//
//  NewsCategory.swift
//  
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

import Foundation

public enum NewsCategory: String, CaseIterable, Decodable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
}
