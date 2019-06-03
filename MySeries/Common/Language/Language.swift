//
//  Language.swift
//  MySeries
//
//  Created by Leticia Echarri on 31/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

enum Language: Equatable {
    case english
    case spanish
}

extension Language {
    
    var code: String {
        switch self {
        case .english:
            return "en"
            
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
    
    var flag: UIImage {
        switch self {
        case .english:
            return UIImage(named: "ukFlag")!
        case .spanish:
            return UIImage(named: "spainFlag")!
        }
    }
}

extension Language {
    
    init?(languageCode: String?) {
        guard let languageCode = languageCode else { return nil }
        switch languageCode {
        case "en":
            self = .english
            
        case "es":
            self = .spanish
            
        default:
            return nil
        }
    }
    
    static func getLanguage() -> String {
        let lang = UserDefaults.standard.string(forKey: "AppleLanguages") ?? ""
        
        return lang
    }
    
    static func getCurrent() -> Language {
        let lang = UserDefaults.standard.string(forKey: "AppleLanguages") ?? ""
        
        switch lang {
        case Language.english.code:
            return .english
        case Language.spanish.code:
            return .spanish
        default:
            return .english
        }
    }
}
