//
//  SearchSerieInteractor.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 20/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SearchSerieInteractorProtocol {
    func searchSerie(text: String)
    func getEpisodes(serieID: Int, completion: @escaping CompletionEpisodeHandler)
    func save(serie: Serie)
    func delete(serieID: Int)
}

protocol SearchSerieInteractorOutput: class {
    func onSuccess(results: [SearchSerieModel])
    func onFailure(error: String)
}

class SearchSerieInteractor {
    let datasource: SearchSerieDataSourceProtocol
    weak var interactorOutput: SearchSerieInteractorOutput?
    
    init(datasource: SearchSerieDataSourceProtocol) {
        self.datasource = datasource
    }
}

extension SearchSerieInteractor: SearchSerieInteractorProtocol {
    func searchSerie(text: String) {
        datasource.searchSerie(text: text, success: { (response) in
            
            let decoder = JSONDecoder()
            
            do {
                if let dataSerie = response as? Data {
                    let results = try decoder.decode([SearchSerieModel].self, from: dataSerie)
                    self.interactorOutput?.onSuccess(results: results)
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
    
    func save(serie: Serie) {
        CoreDataManager().save(serie: serie.name ?? "", id: serie.id)
    }
    
    func delete(serieID: Int) {
        CoreDataManager().deleteSerie(id: serieID)
    }
}
