//
//  SeasonPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeasonPresenterProtocol: ParentPresenterProtocol {
    func getSeasons(serieID: Int)
    func goDetail(episode: Episode, serieID: Int)
    func watch(season: Int, serieID: Int)
    func isWatched(season: Season, serieID: Int, completion: @escaping (_ result: Bool) -> Void)
}

class SeasonPresenter: ParentPresenter {
    
    var view: SeasonsViewControllerProtocol?
    let router: SeasonsRouterProtocol
    let interactor: SeasonsInteractorProtocol
    
    init(router: SeasonsRouterProtocol, interactor: SeasonsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        super.init(parentRouter: router)
    }
}

extension SeasonPresenter: SeasonPresenterProtocol {
    
    func getSeasons(serieID: Int) {
        interactor.getSeasons(serieID: serieID)
    }
    
    func goDetail(episode: Episode, serieID: Int) {
        router.pushDetail(episode: episode, serieID: serieID, view: (view?.getViewController())!)
    }
    
    func watch(season: Int, serieID: Int) {
        interactor.wacth(season: season, serieID: serieID)
    }
    
    func isWatched(season: Season, serieID: Int, completion: @escaping (_ result: Bool) -> Void) {
        
        interactor.watchedEpisodes(season: season.number ?? 0, serieID: serieID) { (watchedEpisodes) in
            
            completion(watchedEpisodes == season.episodeOrder)
        }
    }
}

extension SeasonPresenter: SeasonsInteractorOutput {
    
    func onSuccess(seasons: [Season], serieID: Int) {
        interactor.getEpisodes(serieID: serieID) { (response) in
            
            var seasonsWithEpisodes = [SeasonWithEpisodes]()
            var cont = 0
            for season in seasons {
                var episodes = [Episode]()
                
                for episode in response where (episode.season == season.number) {
                    episodes.append(episode)
                }
                
                var new = SeasonWithEpisodes(season: season, episodes: episodes)
                self.isWatched(season: season, serieID: serieID, completion: { (value) in
                    new.isWatched = value
                    
                    seasonsWithEpisodes.append(new)
                    
                    cont += 1
                    
                    if cont == seasons.count {
                        self.view?.update(seasons: seasonsWithEpisodes)
                    }
                })
            }
        }
    }
    
    func onWatchSuccess() {
        self.view?.updateView()
    }
    
    func onFailure(error: String) {
        print(error)
    }
}
