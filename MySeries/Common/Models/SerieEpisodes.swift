//
//  SerieEpisodes.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 13/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

struct SerieEpisodes {
    var serie: Serie
    var episodes: [Episode]
    
    init(serie: Serie, episodes: [Episode]) {
        self.serie = serie
        self.episodes = episodes
    }
}

struct SerieEpisode {
    var serie: Serie
    var episode: Episode
    
    init(serie: Serie, episode: Episode) {
        self.serie = serie
        self.episode = episode
    }
}
