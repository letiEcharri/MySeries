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
        let datasource = EpisodeDetailDataSource()
        let interactor = EpisodeDetailInteractor(datasource: datasource)
        let presenter = EpisodeDetailPresenter(router: router, interactor: interactor)
        let view = EpisodeDetailViewController(presenter: presenter)
        
        interactor.interactorOutput = presenter
        presenter.view = view
        
        if let myParameters = parameters as? EpisodeDetailParameters {
            view.episode = myParameters.episode
            view.serieID = myParameters.serieID
            view.seasonNumberEpisodes = myParameters.seasonNumberEpisodes
        }
        
        return view
    }
}

extension EpisodeDetailRouter: EpisodeDetailRouterProtocol {
}

struct EpisodeDetailParameters {
    var episode: Episode
    var serieID: Int
    var seasonNumberEpisodes: Int
    
    init(episode: Episode, serieID: Int, seasonNumberEpisodes: Int) {
        self.episode = episode
        self.serieID = serieID
        self.seasonNumberEpisodes = seasonNumberEpisodes
    }
}
