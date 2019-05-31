//
//  ParentRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol ParentRouterProtocol {
    func restartApp()
}

class ParentRouter {
    let mainRouter: MainRouterProtocol
    
    init(mainRouter: MainRouterProtocol) {
        self.mainRouter = mainRouter
    }
}

extension ParentRouter: ParentRouterProtocol {
    func restartApp() {
        mainRouter.restartApp()
    }
}
