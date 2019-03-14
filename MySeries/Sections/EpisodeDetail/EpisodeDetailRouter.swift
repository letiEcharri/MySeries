//
//  EpisodeDetailRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol EpisodeDetailRouterProtocol: ParentRouterProtocol {
}

class EpisodeDetailRouter: ParentRouter {
}

extension EpisodeDetailRouter: RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        let router = EpisodeDetailRouter(mainRouter: mainRouter)
        let presenter = EpisodeDetailPresenter(router: router)
        let view = EpisodeDetailViewController(presenter: presenter)
        
        presenter.view = view
        
        if let episode = parameters as? Episode {
            view.episode = episode
        }
        
        return view
    }
}

extension EpisodeDetailRouter: EpisodeDetailRouterProtocol {
}
