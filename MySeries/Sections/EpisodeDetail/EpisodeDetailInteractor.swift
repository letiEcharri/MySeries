//
//  EpisodeDetailInteractor.swift
//  MySeries
//
//  Created by Leticia Echarri on 20/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol EpisodeDetailInteractorProtocol {
    
    func watch(episode: Episode, value: Bool, serieID: Int)
}

class EpisodeDetailInteractor: EpisodeDetailInteractorProtocol {
    
    init() {
    }
    
    func watch(episode: Episode, value: Bool, serieID: Int) {
        
        if !(CoreDataManager().exitsEpisode(id: episode.id)) {
            CoreDataManager().save(episode: episode.name ?? "", id: episode.id, serieID: serieID, season: episode.season ?? 0)
        }
        CoreDataManager().watchEpisode(id: episode.id, value: value)
    }
}
