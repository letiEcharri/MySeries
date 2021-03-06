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
    func getPendingEpisodes() -> [SerieEpisodes]
    func show(episode: Episode, serieID: Int, seasonNumberEpisodes: Int)
    func goDetail(serie: SerieEpisodes)
    func cleanEpisodes()
}

class HomePresenter: ParentPresenter {
    
    var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol
    let interactor: HomeInteractorProtocol
    
    var pendingSeries = [SerieEpisodes]()
    
    init(router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        super.init(parentRouter: router)
    }
}

extension HomePresenter: HomePresenterProtocol {
    func checkNewEpisodes() {
        interactor.getSeries { (response) in
            let savedSeries = response
            
            if savedSeries.count > 0 {
                self.pendingSeries.removeAll()
                
                var cont = 0
                for item in savedSeries {
                    
                    self.interactor.searchSerie(id: Int(item.id)) { rSerie in
                        self.interactor.searchEpisodes(id: Int(item.id), completion: { rEpisodes in
                            var pendingEpisodes = [Episode]()
                            var epCont = 0
                            
                            cont += 1
                            for ep in rEpisodes {
                                epCont += 1
                                if self.isPending(episode: ep) {
                                    pendingEpisodes.append(ep)
                                }
                            }
                            
                            if pendingEpisodes.count > 0 {
                                let newSerie = SerieEpisodes(serie: rSerie, episodes: pendingEpisodes)
                                self.pendingSeries.append(newSerie)
                            }
                            
                            if (cont == savedSeries.count && epCont == rEpisodes.count) {
                                self.view?.updatePending()
                            }
                            
                            self.view?.updatePending()
                        })
                    }
                }
            } else {
                self.view?.updatePending()
            }
        }
    }
    
    func getPendingEpisodes() -> [SerieEpisodes] {
        let seriesSorted = self.pendingSeries.sorted(by: { getFirstPending(episodes: $0.episodes) > getFirstPending(episodes: $1.episodes) })
        return seriesSorted
    }
    
    private func getFirstPending(episodes: [Episode]) -> Date {
        
        for item in episodes {
            let ep = interactor.get(episode: item.id)
            if !ep.watched {
                return item.airdate?.toDate(format: .date) ?? Date()
            }
        }
        
        return Date()
    }
    
    func show(episode: Episode, serieID: Int, seasonNumberEpisodes: Int) {
        router.pushDetail(episode: episode, serieID: serieID, seasonNumberEpisodes: seasonNumberEpisodes, view: (view?.getViewController())!)
    }
    
    func goDetail(serie: SerieEpisodes) {
        router.pushDetail(serie: serie.serie, view: (view?.getViewController())!)
    }
    
    func cleanEpisodes() {
        self.pendingSeries = [SerieEpisodes]()
    }
    
    
    // Private functions
    
    private func isPending(episode: Episode) -> Bool {
        let savedEpisode = interactor.get(episode: episode.id)
        let epiDate = episode.airstamp?.toDate(format: .complete) ?? Date()
        
        if savedEpisode.watched && epiDate <= Date() {
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
