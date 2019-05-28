//
//  SerieDetailInteractor.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SerieDetailInteractorProtocol {
    func getCast(serieID: Int)
}

protocol SerieDetailInteractorOutput: class {
    func onSuccess(cast: [Cast])
    func onFailure(error: String)
}

class SerieDetailInteractor {
    
    let datasource: SerieDetailDataSourceProtocol
    weak var interactorOutput: SerieDetailInteractorOutput?
    
    init(datasource: SerieDetailDataSourceProtocol) {
        self.datasource = datasource
    }
}

extension SerieDetailInteractor: SerieDetailInteractorProtocol {
    func getCast(serieID: Int) {
        datasource.getCast(id: serieID, success: { (response) in
            
            let decoder = JSONDecoder()
            
            do {
                if let dataSerie = response as? Data {
                    let cast = try decoder.decode([Cast].self, from: dataSerie)
                    self.interactorOutput?.onSuccess(cast: cast)
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
