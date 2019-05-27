//
//  Season.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

struct Season: Codable {
    let id: Int
    let number: Int?
    let name: String?
    let episodeOrder: Int?
    let premiereDate: String?
    let endDate: String?
    let network: SerieNetwork?
    let image: SerieImage?
    let summary: String?
    let links: EpisodeLinks?
    
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case name
        case episodeOrder
        case premiereDate
        case endDate
        case network
        case image
        case summary
        case links = "_links"
    }
}
