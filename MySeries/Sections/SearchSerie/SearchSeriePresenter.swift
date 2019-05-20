//
//  SearchSeriePresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 19/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SearchSeriePresenterProtocol: ParentPresenterProtocol {
    func searchSeries(text: String)
    func save(serie: Serie)
    func delete(serieID: Int)
}

class SearchSeriePresenter: ParentPresenter {
    
    var view: SearchSerieViewControllerProtocol?
    let router: SearchSerieRouterProtocol
    let interactor: SearchSerieInteractorProtocol
    
    init(router: SearchSerieRouterProtocol, interactor: SearchSerieInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        super.init(parentRouter: router)
    }
}

extension SearchSeriePresenter: SearchSeriePresenterProtocol {
    func searchSeries(text: String) {
        interactor.searchSerie(text: text)
    }
    
    func save(serie: Serie) {
        interactor.save(serie: serie)
    }
    
    func delete(serieID: Int) {
        CoreDataManager().deleteSerie(id: serieID)
    }
}

extension SearchSeriePresenter: SearchSerieInteractorOutput {
    func onSuccess(results: [SearchSerieModel]) {
        view?.update(series: results)
    }
    
    func onFailure(error: String) {
        print(error)
    }
}
