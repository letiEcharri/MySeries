//
//  CastRouter.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol CastRouterProtocol: ParentRouterProtocol {
}

class CastRouter: ParentRouter {
}

extension CastRouter: RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        
        let router = CastRouter(mainRouter: mainRouter)
        let presenter = CastPresenter(router: router)
        let view = CastViewController(presenter: presenter)
        
        presenter.view = view
        
        if let cast = parameters as? [Cast] {
            view.cast = cast
        }
        
        return view
    }
}

extension CastRouter: CastRouterProtocol {
}
