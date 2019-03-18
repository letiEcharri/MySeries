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
    func getEpisodesBy(season: Int, serieID: Int, completion: @escaping CompletionEpisodeHandler)
    func getViewWith(episodes: [Episode], width: CGFloat) -> UIView
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
    
    func getEpisodesBy(season: Int, serieID: Int, completion: @escaping CompletionEpisodeHandler) {
        //interactor.getEpisodesBy(season: season, serieID: serieID, completion: completion)
    }
    
    func getViewWith(episodes: [Episode], width: CGFloat) -> UIView {
        let epiView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: CGFloat(episodes.count * 20)))
        
        var cont = 0
        for item in episodes {
            let label = UILabel(frame: CGRect(x: 0, y: CGFloat(cont * 20), width: width, height: 20))
            label.font = UIFont(name: "Noteworthy-Light", size: 15)
            label.text = "\(item.number ?? 0) - \(item.name ?? "")"
            epiView.addSubview(label)
            
            cont += 1
        }
        
        return epiView
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
