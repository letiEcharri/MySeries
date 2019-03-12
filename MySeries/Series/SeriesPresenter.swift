//
//  SeriesPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 7/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeriesPresenterProtocol: ParentPresenterProtocol {
    func navigateToDetail(viewController: UIViewController)
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
    func navigateToDetail(viewController: UIViewController) {
        router.pushDetail(view: viewController)
    }
}
