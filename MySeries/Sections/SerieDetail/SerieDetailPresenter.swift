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
}

class SerieDetailPresenter: ParentPresenter {
    
    var view: SerieDetailViewControllerProtocol?
    let router: SerieDetailRouterProtocol
    
    init(router: SerieDetailRouterProtocol) {
        self.router = router
        super.init(parentRouter: router)
    }
}

extension SerieDetailPresenter: SerieDetailPresenterProtocol {
    func navigateToSeasons(serie: Int) {
        router.pushSeasons(view: (view?.getViewController())!, episodes: [Episode]())
    }
}
