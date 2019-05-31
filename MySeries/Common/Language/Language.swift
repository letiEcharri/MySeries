//
//  Language.swift
//  MySeries
//
//  Created by Leticia Echarri on 31/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

enum Language: Equatable {
    case english
    case spanish
}

extension Language {
    
    var code: String {
        switch self {
        case .english:
            return "en-GB"
            
        case .spanish:
            return "es"
        }
    }
    
    var name: String {
        switch self {
        case .english:
            return "English"
            
        case .spanish:
            return "Spanish"
        }
    }
}

extension Language {
    
    init?(languageCode: String?) {
        guard let languageCode = languageCode else { return nil }
        switch languageCode {
        case "en-GB":
            self = .english
            
        case "es":
            self = .spanish
            
        default:
            return nil
        }
    }
}
