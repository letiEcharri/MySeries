//
//  String+Format.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

enum DateFormat: String {
    case complete = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
    case date = "yyyy-MM-dd"
    case time = "HH:mm:ss"
}

extension String {
    func formatDate() -> String {
        let date = self.components(separatedBy: "-")
        return "\(date[2])/\(date[1])/\(date[0])"
    }
    
    func toDate(format: DateFormat) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let date = dateFormatter.date(from: self)
        
        return date ?? Date()
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
