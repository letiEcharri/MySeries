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
        let presenter = SearchSeriePresenter(router: router)
        let view = SearchSerieViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}

extension SearchSerieRouter: SearchSerieRouterProtocol {
}
