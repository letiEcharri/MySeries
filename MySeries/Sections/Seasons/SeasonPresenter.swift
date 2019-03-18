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
    func goDetail(episode: Episode)
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
    
    func goDetail(episode: Episode) {
        router.pushDetail(episode: episode, view: (view?.getViewController())!)
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
                seasonsWithEpisodes.append(SeasonWithEpisodes(season: season, episodes: episodes))
                cont += 1
                
                if cont == seasons.count {
                    self.view?.update(seasons: seasonsWithEpisodes)
                }
            }
        }
    }
    
    func onFailure(error: String) {
        print(error)
    }
}
