//
//  SeriesRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeriesRouterProtocol: ParentRouterProtocol {
    func pushDetail(view: UIViewController)
}

class SeriesRouter: ParentRouter {
}

extension SeriesRouter: RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol) -> UIViewController {
        let router = SeriesRouter(mainRouter: mainRouter)
        let presenter = SeriesPresenter(router: router)
        let view = SeriesViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}

extension SeriesRouter: SeriesRouterProtocol {
    
    func pushDetail(view: UIViewController) {
        let detailVC = SerieDetailViewController()
        mainRouter.push(navigationController: view.navigationController, viewController: detailVC, animated: true)
    }
}
