//
//  SeriesPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 7/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SeriesPresenterProtocol: ParentPresenterProtocol {
}

class SeriesPresenter: ParentPresenter {
    var view: SeriesViewControllerProtocol?
    let router: SeriesRouterProtocol
    
    init(router: SeriesRouterProtocol) {
        self.router = router
        super.init(parentRouter: router)
    }
}

extension SeriesPresenter: SeriesPresenterProtocol {
}
