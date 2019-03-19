//
//  SearchSeriePresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 19/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SearchSeriePresenterProtocol: ParentPresenterProtocol {
}

class SearchSeriePresenter: ParentPresenter {
    
    var view: SearchSerieViewControllerProtocol?
    let router: SearchSerieRouterProtocol
    
    init(router: SearchSerieRouterProtocol) {
        self.router = router
        super.init(parentRouter: router)
    }
}

extension SearchSeriePresenter: SearchSeriePresenterProtocol {
}
