//
//  Episode.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

struct Episode: Codable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int
    let airdate: String
    let airtime: String
    let airstamp: String
    let runtime: Int
    let image: String
    let summary: String
    let links: EpisodeLinks
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case season
        case number
        case airdate
        case airtime
        case airstamp
        case runtime
        case image
        case summary
        case links = "_links"
    }
}

struct EpisodeLinks: Codable {
    let selff: SerieLinksRef
    
    enum CodingKeys: String, CodingKey {
        case selff = "self"
    }
}
