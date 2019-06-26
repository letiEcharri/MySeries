//
//  ProfilePresenter.swift
//  MySeries
//
//  Created by Leticia Echarri on 26/06/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol: ParentPresenterProtocol {
}

class ProfilePresenter: ParentPresenter {
    
    var view: ProfileViewControllerProtocol?
    let router: ProfileRouterProtocol
    
    init(router: ProfileRouterProtocol) {
        self.router = router
        super.init(parentRouter: router)
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
}
