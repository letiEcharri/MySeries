//
//  Person.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

struct Person: Codable {
    let id: Int
    let url: String?
    let name: String?
    let country: SerieCountry?
    let birthday: String?
    let gender: String?
    let image: SerieImage?
    let links: SerieLinks?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case country
        case birthday
        case gender
        case image
        case links = "_links"
    }
}
