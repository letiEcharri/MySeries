//
//  EpisodeDetailPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol EpisodeDetailPresenterProtocol: ParentPresenterProtocol {
    func watch(episode: Episode, value: Bool)
    func isWatched(episodeID: Int) -> Bool
}

class EpisodeDetailPresenter: ParentPresenter {
    
    var view: EpisodeDetailViewControllerProtocol?
    let router: EpisodeDetailRouterProtocol
    
    init(router: EpisodeDetailRouterProtocol) {
        self.router = router
        super.init(parentRouter: router)
    }
}

extension EpisodeDetailPresenter: EpisodeDetailPresenterProtocol {
    func watch(episode: Episode, value: Bool) {
        if !(CoreDataManager().exitsEpisode(id: episode.id)) {
            CoreDataManager().save(episode: episode.name ?? "", id: episode.id)
        }
        CoreDataManager().watchEpisode(id: episode.id, value: value)
    }
    
    func isWatched(episodeID: Int) -> Bool {
        let episode = CoreDataManager().fetchEpisode(id: episodeID)
        return episode.watched
    }
}
