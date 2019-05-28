//
//  Character.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int
    let url: String?
    let name: String?
    let image: SerieImage?
    let links: SerieLinks?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case image
        case links = "_links"
    }
}
