//
//  Number+Format.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 19/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
