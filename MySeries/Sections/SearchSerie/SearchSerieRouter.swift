//
//  SearchSerieRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 19/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SearchSerieRouterProtocol: ParentRouterProtocol {
}

class SearchSerieRouter: ParentRouter {
}

extension SearchSerieRouter: RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        let router = SearchSerieRouter(mainRouter: mainRouter)
        let datasource = SearchSerieDataSource()
        let interactor = SearchSerieInteractor(datasource: datasource)
        let presenter = SearchSeriePresenter(router: router, interactor: interactor)
        let view = SearchSerieViewController(presenter: presenter)
        
        interactor.interactorOutput = presenter
        presenter.view = view
        
        return view
    }
}

extension SearchSerieRouter: SearchSerieRouterProtocol {
}
