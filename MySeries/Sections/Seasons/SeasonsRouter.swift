//
//  SeasonsRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit
protocol SeasonsRouterProtocol: ParentRouterProtocol {
}

class SeasonsRouter: ParentRouter {
}

extension SeasonsRouter: RouterFactory {
    
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        let router = SeasonsRouter(mainRouter: mainRouter)
        let presenter = SeasonPresenter(router: router)
        let view = SeasonsViewController(presenter: presenter)
        
        presenter.view = view
        
        if let episodes = parameters as? [Episode] {
            view.episodes = episodes
        }
        
        return view
    }
}

extension SeasonsRouter: SeasonsRouterProtocol {
}
