//
//  UIView+CornerRadius.swift
//  MySeries
//
//  Created by Leticia Echarri on 03/06/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

extension UIView {
    
    func setCorner(radius: CGFloat, color: UIColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
    }
}
