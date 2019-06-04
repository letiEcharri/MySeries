//
//  SerieDetailPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SerieDetailPresenterProtocol: ParentPresenterProtocol {
    func navigateToSeasons(serie: Int)
    func openCast(serieID: Int)
    func save(score: Int, serieID: Int)
    func getScore(serieID: Int) -> Int
}

class SerieDetailPresenter: ParentPresenter {
    
    var view: SerieDetailViewControllerProtocol?
    let router: SerieDetailRouterProtocol
    let interactor: SerieDetailInteractorProtocol
    
    init(router: SerieDetailRouterProtocol, interactor: SerieDetailInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        super.init(parentRouter: router)
    }
}

extension SerieDetailPresenter: SerieDetailPresenterProtocol {
    func navigateToSeasons(serie: Int) {
        router.pushSeasons(view: (view?.getViewController())!, serieID: serie)
    }
    
    func openCast(serieID: Int) {
        interactor.getCast(serieID: serieID)
    }
    
    func save(score: Int, serieID: Int) {
        interactor.save(score: score, serieID: serieID)
    }
    
    func getScore(serieID: Int) -> Int {
        return interactor.getScore(serieID: serieID)
    }
}

extension SerieDetailPresenter: SerieDetailInteractorOutput {
    func onSuccess(cast: [Cast]) {
        router.presentCast(view: (view?.getViewController())!, cast: cast)
    }
    
    func onFailure(error: String) {
        print(error)
    }
    
}
