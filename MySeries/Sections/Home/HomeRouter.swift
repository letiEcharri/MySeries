//
//  HomeRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol: ParentRouterProtocol {
    func pushDetail(serie: Serie, view: UIViewController)
    func pushDetail(episode: Episode, serieID: Int, view: UIViewController)
}

class HomeRouter: ParentRouter {
}

extension HomeRouter: RouterFactory {
    
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        let router = HomeRouter(mainRouter: mainRouter)
        let datasource = HomeDataSource()
        let interactor = HomeInteractor(datasource: datasource)
        let presenter = HomePresenter(router: router, interactor: interactor)
        let view = HomeViewController(presenter: presenter)
        
        interactor.interactorOutput = presenter
        presenter.view = view
        
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    func pushDetail(serie: Serie, view: UIViewController) {
        let detailVC = SerieDetailRouter.create(withMainRouter: mainRouter, parameters: serie as AnyObject)
        mainRouter.push(navigationController: view.navigationController, viewController: detailVC, animated: true)
    }
    
    func pushDetail(episode: Episode, serieID: Int, view: UIViewController) {
        let parameters = EpisodeDetailParameters(episode: episode, serieID: serieID)
        let detailVC = EpisodeDetailRouter.create(withMainRouter: mainRouter, parameters: parameters as AnyObject)
        mainRouter.push(navigationController: view.navigationController, viewController: detailVC, animated: true)
    }
}
