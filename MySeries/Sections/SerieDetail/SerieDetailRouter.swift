//
//  SerieDetailRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SerieDetailRouterProtocol: ParentRouterProtocol {
    func pushSeasons(view: UIViewController, episodes: [Episode])
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
    
    func pushSeasons(view: UIViewController, episodes: [Episode]) {
        let seasonsVC = SeasonsRouter.create(withMainRouter: mainRouter, parameters: episodes as AnyObject)
        mainRouter.push(navigationController: view.navigationController, viewController: seasonsVC, animated: true)
    }
}
