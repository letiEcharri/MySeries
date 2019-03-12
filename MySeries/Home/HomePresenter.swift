//
//  HomePresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 7/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol: ParentPresenterProtocol {
}

class HomePresenter: ParentPresenter {
    
    var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol
    
    init(router: HomeRouterProtocol) {
        self.router = router
        super.init(parentRouter: router)
    }
}

extension HomePresenter: HomePresenterProtocol {
}
