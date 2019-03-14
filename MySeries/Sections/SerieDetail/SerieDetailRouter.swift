//
//  SerieDetailRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SerieDetailRouterProtocol: ParentRouterProtocol {
}

class SerieDetailRouter: ParentRouter {
}

extension SerieDetailRouter: RouterFactory {
    
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        let router = SerieDetailRouter(mainRouter: mainRouter)
        let presenter = SerieDetailPresenter(router: router)
        let view = SerieDetailViewController(presenter: presenter)
        
        presenter.view = view
        
        if let serie = parameters as? Serie {
            view.serie = serie
        }
        
        return view
    }
}

extension SerieDetailRouter: SerieDetailRouterProtocol {
}
