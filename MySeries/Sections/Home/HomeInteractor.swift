//
//  HomeInteractor.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

typealias CompletionSerieHandler = (_ serie:Serie) -> Void
typealias CompletionEpisodeHandler = (_ episode:[Episode]) -> Void

protocol HomeInteractorProtocol {
    func searchSerie(id: Int, completion: @escaping CompletionSerieHandler)
    func searchEpisodes(url: String, completion: @escaping CompletionEpisodeHandler)
    func searchEpisode(url: String)
}

protocol HomeInteractorOutput: class {
    func onSuccess(espisode: Episode)
    func onFailure(error: String)
}

class HomeInteractor {
    let datasource: HomeDataSourceProtocol
    weak var interactorOutput: HomeInteractorOutput?
    
    init(datasource: HomeDataSourceProtocol) {
        self.datasource = datasource
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func searchSerie(id: Int, completion: @escaping CompletionSerieHandler) {
        datasource.searchSerie(id: id, success: { response in
            
            let decoder = JSONDecoder()
            
            do {
                if let dataSerie = response as? Data {
                    let serie = try decoder.decode(Serie.self, from: dataSerie)
                    //self.interactorOutput?.onSuccess(serie: serie)
                    completion(serie)
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
    
    func searchEpisodes(url: String, completion: @escaping CompletionEpisodeHandler) {
        datasource.searchEpisode(url: url, success: { response in
            
            let decoder = JSONDecoder()
            
            do {
                if let dataSerie = response as? Data {
                    let episodes = try decoder.decode([Episode].self, from: dataSerie)
                    completion(episodes)
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
    
    func searchEpisode(url: String) {
        datasource.searchEpisode(url: url, success: { response in
            
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
