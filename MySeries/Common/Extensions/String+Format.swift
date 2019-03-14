//
//  String+Format.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

extension String {
    func formatDate() -> String {
        let date = self.components(separatedBy: "-")
        return "\(date[2])/\(date[1])/\(date[0])"
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: self)
        
        return date ?? Date()
    }
}
