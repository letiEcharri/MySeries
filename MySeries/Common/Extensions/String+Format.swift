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
}
