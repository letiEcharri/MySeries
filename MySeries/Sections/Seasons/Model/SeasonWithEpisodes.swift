//
//  SeasonWithEpisodes.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 15/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

struct SeasonWithEpisodes {
    
    var season: Season
    var episodes: [Episode]
    var isOpen: Bool = false
    var isWatched = false
    
    init(season: Season, episodes: [Episode]) {
        self.season = season
        self.episodes = episodes
    }
}
