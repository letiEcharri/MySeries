//
//  SeasonPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SeasonPresenterProtocol: ParentPresenterProtocol {
    func getSeasons(serieID: Int)
}

class SeasonPresenter: ParentPresenter {
    
    var view: SeasonsViewControllerProtocol?
    let router: SeasonsRouterProtocol
    let interactor: SeasonsInteractorProtocol
    
    init(router: SeasonsRouterProtocol, interactor: SeasonsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        super.init(parentRouter: router)
    }
}

extension SeasonPresenter: SeasonPresenterProtocol {
    
    func getSeasons(serieID: Int) {
        interactor.getSeasons(serieID: serieID)
    }
}

extension SeasonPresenter: SeasonsInteractorOutput {
    
    func onSuccess(seasons: [Season]) {
        view?.update(seasons: seasons)
    }
    
    func onFailure(error: String) {
        print(error)
    }
}
