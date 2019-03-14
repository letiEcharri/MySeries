//
//  EpisodeDetailPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol EpisodeDetailPresenterProtocol: ParentPresenterProtocol {
}

class EpisodeDetailPresenter: ParentPresenter {
    
    var view: EpisodeDetailViewControllerProtocol?
    let router: EpisodeDetailRouterProtocol
    
    init(router: EpisodeDetailRouterProtocol) {
        self.router = router
        super.init(parentRouter: router)
    }
}

extension EpisodeDetailPresenter: EpisodeDetailPresenterProtocol {
}
