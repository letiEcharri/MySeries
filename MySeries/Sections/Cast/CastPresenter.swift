//
//  CastPresenter.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol CastPresenterProtocol: ParentPresenterProtocol {
    func close(view: CastViewController)
}

class CastPresenter: ParentPresenter {
    
    var view: CastViewControllerProtocol?
    let router: CastRouter
    
    init(router: CastRouter) {
        self.router = router
        super.init(parentRouter: router)
    }
}

extension CastPresenter: CastPresenterProtocol {
    
    func close(view: CastViewController) {
        view.dismiss(animated: true, completion: nil)
    }
}
