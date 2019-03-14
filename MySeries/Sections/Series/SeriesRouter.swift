//
//  SeriesRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeriesRouterProtocol: ParentRouterProtocol {
    func pushDetail(view: UIViewController, serie: Serie)
}

class SeriesRouter: ParentRouter {
}

extension SeriesRouter: RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        let router = SeriesRouter(mainRouter: mainRouter)
        let datasource = SerieDataSource()
        let interactor = SerieInteractor(datasource: datasource)
        let presenter = SeriesPresenter(router: router, interactor: interactor)
        let view = SeriesViewController(presenter: presenter)
        
        interactor.interactorOutput = presenter
        presenter.view = view
        
        return view
    }
}

extension SeriesRouter: SeriesRouterProtocol {
    
    func pushDetail(view: UIViewController, serie: Serie) {
        let detailVC = SerieDetailRouter.create(withMainRouter: mainRouter, parameters: serie as AnyObject)
        mainRouter.push(navigationController: view.navigationController, viewController: detailVC, animated: true)
    }
}
