//
//  SerieDetailRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SerieDetailRouterProtocol: ParentRouterProtocol {
    func pushSeasons(view: UIViewController, serieID: Int)
    func presentCast(view: UIViewController, cast: [Cast])
}

class SerieDetailRouter: ParentRouter {
}

extension SerieDetailRouter: RouterFactory {
    
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        let router = SerieDetailRouter(mainRouter: mainRouter)
        let datasource = SerieDetailDataSource()
        let interactor = SerieDetailInteractor(datasource: datasource)
        let presenter = SerieDetailPresenter(router: router, interactor: interactor)
        let view = SerieDetailViewController(presenter: presenter)
        
        interactor.interactorOutput = presenter
        presenter.view = view
        
        if let serie = parameters as? Serie {
            view.serie = serie
        }
        
        return view
    }
}

extension SerieDetailRouter: SerieDetailRouterProtocol {
    
    func pushSeasons(view: UIViewController, serieID: Int) {
        let seasonsVC = SeasonsRouter.create(withMainRouter: mainRouter, parameters: serieID as AnyObject)
        mainRouter.push(navigationController: view.navigationController, viewController: seasonsVC, animated: true)
    }
    
    func presentCast(view: UIViewController, cast: [Cast]) {
        let castVC = CastRouter.create(withMainRouter: mainRouter, parameters: cast as AnyObject)
        
        castVC.modalPresentationStyle = .overCurrentContext
        mainRouter.present(viewController: castVC, animated: true, completion: nil)
    }
}
