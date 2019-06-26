//
//  ProfileRouter.swift
//  MySeries
//
//  Created by Leticia Echarri on 26/06/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol ProfileRouterProtocol: ParentRouterProtocol {
}

class ProfileRouter: ParentRouter {
}

extension ProfileRouter: RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        
        let router = ProfileRouter(mainRouter: mainRouter)
        let presenter = ProfilePresenter(router: router)
        let view = ProfileViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}

extension ProfileRouter: ProfileRouterProtocol {
}
