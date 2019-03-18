//
//  SeasonsInteractor.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SeasonsInteractorProtocol {
    func getSeasons(serieID: Int)
    func getEpisodes(serieID: Int, completion: @escaping CompletionEpisodeHandler)
}

protocol SeasonsInteractorOutput: class {
    func onSuccess(seasons: [Season], serieID: Int)
    func onFailure(error: String)
}

class SeasonsInteractor {
    
    let datasource: SeasonsDataSourceProtocol
    weak var interactorOutput: SeasonsInteractorOutput?
    
    init(datasource: SeasonsDataSourceProtocol) {
        self.datasource = datasource
    }
}

extension SeasonsInteractor: SeasonsInteractorProtocol {
    
    func getSeasons(serieID: Int) {
        
        datasource.getSeasons(idSerie: serieID, success: { response in
            
            let decoder = JSONDecoder()
            
            do {
                if let dataSeasons = response as? Data {
                    let seasons = try decoder.decode([Season].self, from: dataSeasons)
                    self.interactorOutput?.onSuccess(seasons: seasons, serieID: serieID)
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
    
    func getEpisodes(serieID: Int, completion: @escaping CompletionEpisodeHandler) {
        
        datasource.getEpisodes(idSerie: serieID, success: { (response) in
            
            let decoder = JSONDecoder()
            
            do {
                if let data = response as? Data {
                    
                    let episodes = try decoder.decode([Episode].self, from: data)
                    
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
}
