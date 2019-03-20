//
//  Serie.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 8/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

struct Serie: Codable {
    let id: Int
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let statusSerie: String?
    let runtime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule: SerieSchedule?
    let rating: SerieRating?
    let weight: Int?
    let network: SerieNetwork?
    let image: SerieImage?
    let summary: String?
    let updated: Int?
    let links: SerieLinks?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case type
        case language
        case genres
        case statusSerie = "status"
        case runtime
        case premiered
        case officialSite
        case schedule
        case rating
        case weight
        case network
        case image
        case summary
        case updated
        case links = "_links"
    }
}

struct SerieSchedule: Codable {
    let time: String
    let days: [String]
}

struct SerieRating: Codable {
    let average: Double?
}

struct SerieNetwork: Codable {
    let id: Int
    let name: String
    let country: SerieCountry
}

struct SerieCountry: Codable {
    let name: String
    let code: String
    let timezone: String
}

struct SerieImage: Codable {
    let medium: String
    let original: String
}

struct SerieLinks: Codable {
    let selff: SerieLinksRef
    let previousepisode: SerieLinksRef?
    let nextepisode: SerieLinksRef?
    
    enum CodingKeys: String, CodingKey {
        case selff = "self"
        case previousepisode
        case nextepisode
    }
}

struct SerieLinksRef: Codable {
    let href: String
}
