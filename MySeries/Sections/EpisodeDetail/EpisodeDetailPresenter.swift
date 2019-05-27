//
//  EpisodeDetailPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol EpisodeDetailPresenterProtocol: ParentPresenterProtocol {
    func watch(episode: Episode, value: Bool, serieID: Int)
    func isWatched(episodeID: Int, completion: @escaping (_ value: Bool) -> Void)
}

class EpisodeDetailPresenter: ParentPresenter {
    
    var view: EpisodeDetailViewControllerProtocol?
    let router: EpisodeDetailRouterProtocol
    let interactor: EpisodeDetailInteractorProtocol
    
    init(router: EpisodeDetailRouterProtocol, interactor: EpisodeDetailInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        super.init(parentRouter: router)
    }
}

extension EpisodeDetailPresenter: EpisodeDetailPresenterProtocol {
    
    func watch(episode: Episode, value: Bool, serieID: Int) {
        interactor.watch(episode:episode, value: value, serieID: serieID)
    }
    
    func isWatched(episodeID: Int, completion: @escaping (Bool) -> Void) {
        interactor.getEpisode(episodeID: episodeID) { (response) in
            completion(response.watched)
        }
    }
}
