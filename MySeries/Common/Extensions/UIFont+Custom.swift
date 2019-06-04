//
//  UIFont+Custom.swift
//  MySeries
//
//  Created by Leticia Echarri on 03/06/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum FontType {
        case bold
        case light
    }
    
    func appFont(type: FontType, size: CGFloat) -> UIFont {
        switch type {
        case .bold:
            return UIFont(name: "Noteworthy-Bold", size: size) ?? UIFont()
        case .light:
            return UIFont(name: "Noteworthy-Light", size: size) ?? UIFont()
        }
    }
}
