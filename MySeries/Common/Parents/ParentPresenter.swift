//
//  ParentPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol ParentPresenterProtocol {
}

class ParentPresenter {
    
    let parentRouter: ParentRouterProtocol
    
    init(parentRouter: ParentRouterProtocol) {
        self.parentRouter = parentRouter
    }
}

extension ParentPresenter: ParentPresenterProtocol {
}
