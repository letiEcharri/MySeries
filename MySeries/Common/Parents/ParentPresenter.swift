//
//  ParentPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol ParentPresenterProtocol {
    func restartApp()
}

class ParentPresenter {
    
    let parentRouter: ParentRouterProtocol
    
    init(parentRouter: ParentRouterProtocol) {
        self.parentRouter = parentRouter
    }
}

extension ParentPresenter: ParentPresenterProtocol {
    func restartApp() {
        parentRouter.restartApp()
    }
}
