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
}

struct Prueba: Codable {
    let score: Double
}
