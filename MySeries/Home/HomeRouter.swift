//
//  HomeRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol: ParentRouterProtocol {
}

class HomeRouter: ParentRouter, HomeRouterProtocol {
}

extension HomeRouter: RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol) -> UIViewController {
        let router = HomeRouter(mainRouter: mainRouter)
        let presenter = HomePresenter(router: router)
        let view = HomeViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
