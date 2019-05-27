//
//  SerieInteractor.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SerieInteractorProtocol {
    func searchSerie(id: Int)
    func getSeries(completion: @escaping (_ series: [CDSerie]) -> Void)
}

protocol SerieInteractorOutput: class {
    func onSuccess(data: Serie)
    func onFailure(error: String)
}

class SerieInteractor {
    
    let datasource: SerieDataSourceProtocol
    weak var interactorOutput: SerieInteractorOutput?
    
    init(datasource: SerieDataSourceProtocol) {
        self.datasource = datasource
    }
}

extension SerieInteractor: SerieInteractorProtocol {
    func searchSerie(id: Int) {
        datasource.searchSerie(id: id, success: { response in
            
            let decoder = JSONDecoder()
            
            do {
                if let dataSerie = response as? Data {
                    let serie = try decoder.decode(Serie.self, from: dataSerie)
                    self.interactorOutput?.onSuccess(data: serie)
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
    
    func getSeries(completion: @escaping ([CDSerie]) -> Void) {
        let series = CoreDataManager().fetchSeries().sorted(by: { ($0.value(forKeyPath: "name") as! String).localizedCaseInsensitiveCompare(($1.value(forKeyPath: "name") as! String)) == ComparisonResult.orderedAscending } )
        
        completion(series)
    }
}
