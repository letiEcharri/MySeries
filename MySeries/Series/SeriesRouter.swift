//
//  SeriesRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeriesRouterProtocol: ParentRouterProtocol {
}

class SeriesRouter: ParentRouter, SeriesRouterProtocol {
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
