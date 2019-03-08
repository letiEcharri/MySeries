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
    let url: String
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let status: String
    let runtime: String
    let premiere: String
    let officialSite: String
    let schedule: SerieSchedule
    let rating: SerieRating
    let weight: Int
    let network: SerieNetwork
    let image: SerieImage
    let summary: String
    let updated: Int
    let links: SerieLinks
}

struct SerieSchedule: Codable {
    let time: String
    let days: [String]
}

struct SerieRating: Codable {
    let average: Int
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
    let previousepisode: SerieLinksRef
    let nextepisode: SerieLinksRef
}

struct SerieLinksRef: Codable {
    let href: String
}
