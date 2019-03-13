//
//  HomePresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 7/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol: ParentPresenterProtocol {
    func checkNewEpisodes()
}

class HomePresenter: ParentPresenter {
    
    var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol
    let interactor: HomeInteractorProtocol
    
    let savedSeries = CoreDataManager().fetchSeries()
    var pendingSeries = [SerieEpisodes]()
    
    init(router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        super.init(parentRouter: router)
    }
}

extension HomePresenter: HomePresenterProtocol {
    func checkNewEpisodes() {
        
        var cont = 0
        for item in savedSeries {
            
            interactor.searchSerie(id: Int(item.id)) { rSerie in
                let url = "http://api.tvmaze.com/shows/\(rSerie.id)/episodes"
                self.interactor.searchEpisodes(url: url, completion: { rEpisodes in
                    var pendingEpisodes = [Episode]()
                    var epCont = 0
                    
                    cont += 1
                    for ep in rEpisodes {
                        epCont += 1
                        if self.isPending(episode: ep) {
                            pendingEpisodes.append(ep)
                        }
                    }
                    
                    let newSerie = SerieEpisodes(serie: rSerie, episodes: pendingEpisodes)
                    self.pendingSeries.append(newSerie)
                    
                    if (cont == self.savedSeries.count && epCont == rEpisodes.count) {
                        self.view?.updatePending(episodes: self.pendingSeries)
                    }
                })
            }
        }
    }
    
    private func isPending(episode: Episode) -> Bool {
        let savedEpisode = CoreDataManager().fetchEpisode(id: episode.id)
        
        if savedEpisode.watched {
            return false
        } 
        
        return true
    }
}

extension HomePresenter: HomeInteractorOutput {
    
    func onSuccess(espisode: Episode) {
    }
    
    func onFailure(error: String) {
        print(error)
    }
}
