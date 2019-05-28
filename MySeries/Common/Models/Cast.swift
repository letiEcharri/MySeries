//
//  Cast.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

struct Cast: Codable {
    let person: Person
    let character: Character
    let selff: Bool
    let voice: Bool
    
    enum CodingKeys: String, CodingKey {
        case person
        case character
        case selff = "self"
        case voice
    }
}
