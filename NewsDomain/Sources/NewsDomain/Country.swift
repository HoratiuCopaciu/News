//
//  File.swift
//  
//
//  Created by Horatiu Copaciu on 30.10.2021.
//

import Foundation

public enum Country: String, CaseIterable {
    case unitedArabEmirates = "United Arab Emirates"
    case argentina = "Argentina"
    case austria = "Austria"
    case australia = "Australia"
    case belgium = "Belgium"
    case bulgaria = "Bulgaria"
    case brazil = "Brazil"
    case canada = "Canada"
    case swizerland = "Swizerland"
    case germany = "Germany"
    case unitedStates = "United State of America"
}

public extension Country {
    var isoCode: String {
        switch self {
        case .unitedArabEmirates:
            return "AE"
        case .unitedStates:
            return "US"
        case .argentina:
            return "AR"
        case .australia:
            return "AU"
        case .austria:
            return "AT"
        case .belgium:
            return "BE"
        case .brazil:
            return "BR"
        case .bulgaria:
            return "BG"
        case .canada:
            return "CA"
        case .swizerland:
            return "CH"
        case .germany:
            return "DE"
        }
    }
}
