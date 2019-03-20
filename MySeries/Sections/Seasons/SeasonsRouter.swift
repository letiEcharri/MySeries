//
//  SeasonsRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit
protocol SeasonsRouterProtocol: ParentRouterProtocol {
    func pushDetail(episode: Episode, view: UIViewController)
}

class SeasonsRouter: ParentRouter {
}

extension SeasonsRouter: RouterFactory {
    
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        let router = SeasonsRouter(mainRouter: mainRouter)
        let datasource = SeasonsDataSource()
        let interactor = SeasonsInteractor(datasource: datasource)
        let presenter = SeasonPresenter(router: router, interactor: interactor)
        let view = SeasonsViewController(presenter: presenter)
        
        interactor.interactorOutput = presenter
        presenter.view = view
        
        if let serieID = parameters as? Int {
            view.serieID = serieID
        }
        
        return view
    }
}

extension SeasonsRouter: SeasonsRouterProtocol {
    
    func pushDetail(episode: Episode, view: UIViewController) {
        let detailVC = EpisodeDetailRouter.create(withMainRouter: mainRouter, parameters: episode as AnyObject)
        mainRouter.push(navigationController: view.navigationController, viewController: detailVC, animated: true)
    }
}