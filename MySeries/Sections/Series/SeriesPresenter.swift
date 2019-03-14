//
//  SeriesPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 7/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeriesPresenterProtocol: ParentPresenterProtocol {
    func navigateToDetail(serie: CDSerie)
    func navigateToSeasons(episodes: [Episode])
}

class SeriesPresenter: ParentPresenter {
    var view: SeriesViewControllerProtocol?
    let router: SeriesRouterProtocol
    var interactor: SerieInteractorProtocol
    
    init(router: SeriesRouterProtocol, interactor: SerieInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        super.init(parentRouter: router)
    }
}

extension SeriesPresenter: SeriesPresenterProtocol {
    func navigateToDetail(serie: CDSerie) {
        interactor.searchSerie(id: Int(serie.id))
    }
    
    func navigateToSeasons(episodes: [Episode]) {
        router.pushSeasons(view: (view?.getViewController())!, episodes: episodes)
    }
}

extension SeriesPresenter: SerieInteractorOutput {
    func onSuccess(data: Serie) {
        router.pushDetail(view: (view?.getViewController())!, serie: data)
    }
    
    func onFailure(error: String) {
        print(error)
    }
}
