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
    func getEpisode(episodeID: Int, compeltion: @escaping (_ episode: CDEpisode) -> Void)
    func getEpisode(serieID: Int, season: Int, number: Int)
}

protocol EpisodeDetailInteractorOutput: class {
    func onSuccess(espisode: Episode)
    func onFailure(error: String)
}

class EpisodeDetailInteractor {
    
    let datasource: EpisodeDetailDataSourceProtocol
    weak var interactorOutput: EpisodeDetailInteractorOutput?
    
    init(datasource: EpisodeDetailDataSourceProtocol) {
        self.datasource = datasource
    }
}

extension EpisodeDetailInteractor: EpisodeDetailInteractorProtocol {
    
    func watch(episode: Episode, value: Bool, serieID: Int) {
        
        if !(CoreDataManager().exitsEpisode(id: episode.id)) {
            CoreDataManager().save(episode: episode.name ?? "", id: episode.id, serieID: serieID, season: episode.season ?? 0)
        }
        CoreDataManager().watchEpisode(id: episode.id, value: value)
    }
    
    func getEpisode(episodeID: Int, compeltion: @escaping (CDEpisode) -> Void) {
        let episode = CoreDataManager().fetchEpisode(id: episodeID)
        
        compeltion(episode)
    }
    
    func getEpisode(serieID: Int, season: Int, number: Int) {
        datasource.searchEpisode(id: serieID, season: season, number: number, success: { (response) in
            
            let decoder = JSONDecoder()
            
            do {
                if let dataSerie = response as? Data {
                    let episode = try decoder.decode(Episode.self, from: dataSerie)
                    self.interactorOutput?.onSuccess(espisode: episode)
                    
                } else {
                    self.interactorOutput?.onFailure(error: "Interactor error: No Data")
                }
                
            } catch {
                self.interactorOutput?.onFailure(error: error.localizedDescription)
            }
            
        }) { (error) in
            self.interactorOutput?.onFailure(error: error.localizedDescription)
        }
    }
}
