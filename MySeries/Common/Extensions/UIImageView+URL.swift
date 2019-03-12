//
//  UIImageView+URL.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let data = try? Data(contentsOf: url)
            if let imageData = data {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
